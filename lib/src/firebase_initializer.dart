import 'package:artitecture/src/presentation/deep_link_manager.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

Future<void> initializeFirebase() async {
  const notificationChannelId = "notification_channel_id";
  const notificationChannelName = "Notification Channel Name";
  const notificationChannelDescription = "Notification Channel Description";

  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

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