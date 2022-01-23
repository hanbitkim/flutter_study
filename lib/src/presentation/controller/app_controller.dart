import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:artitecture/src/presentation/deep_link_manager.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class AppController extends GetxController {
  static const notificationChannelId = "notification_channel_id";
  static const notificationChannelName = "Notification Channel Name";
  static const notificationChannelDescription = "Notification Channel Description";

  static AppController get to => Get.find();

  final IsSignInUseCase isSignInUseCase;

  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();

  AppController(this.isSignInUseCase);

  @override
  void onInit() {
    _initNotification();
    _initDynamicLink();
    super.onInit();
  }

  Future<bool> isSignIn() {
    return isSignInUseCase();
  }

  void _initNotification() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    const AndroidNotificationChannel androidNotificationChannel = AndroidNotificationChannel(
      notificationChannelId,
      notificationChannelName,
      description: notificationChannelDescription,
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
    await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
            iOS: IOSInitializationSettings()),
        onSelectNotification: (String? payload) async {

        });

    FirebaseMessaging.onMessage.listen((RemoteMessage rm) {
      Logger().d("foreground remoteMessage = ${rm.data.toString()}");

      message.value = rm;
      RemoteNotification? notification = rm.notification;
      AndroidNotification? android = rm.notification?.android;

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          0,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              notificationChannelId,
              notificationChannelName,
              channelDescription: notificationChannelDescription,
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage rm) {
      Logger().d("background remoteMessage = ${rm.data.toString()}");
      DeepLinkManager.handleUrl(rm.data["deepLink"]);
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      Logger().d("initial remoteMessage = ${initialMessage.data.toString()}");
      DeepLinkManager.handleUrl(initialMessage.data["deepLink"]);
    }
  }

  void _initDynamicLink() async {
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData event) {
      Logger().d("dynamicLink = ${event.link}");
        DeepLinkManager.handleUri(event.link);
    }).onError((error) {
      Logger().d("dynamicLink error = ${error.toString()}");
    });

    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    if (deepLink != null) {
      DeepLinkManager.handleUri(deepLink);
    }
  }
}
