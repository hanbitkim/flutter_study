import 'dart:io';

import 'package:artitecture/src/domain/usecase/check_app_version_usecase.dart';
import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:artitecture/src/presentation/deep_link_manager.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:version/version.dart';

class AppController extends GetxController {
  static const notificationChannelId = "notification_channel_id";
  static const notificationChannelName = "Notification Channel Name";
  static const notificationChannelDescription = "Notification Channel Description";

  static AppController get to => Get.find();

  final CheckAppVersionUseCase _checkAppVersionUseCase;
  final IsSignInUseCase _isSignInUseCase;

  final Rxn<RemoteMessage> message = Rxn<RemoteMessage>();

  AppController(this._checkAppVersionUseCase, this._isSignInUseCase);

  @override
  void onInit() {
    _initNotification();
    _initDynamicLink();
    super.onInit();
  }

  Future<bool> isSignIn() async {
    var response = await _checkAppVersionUseCase();
    if (response.isSuccess()) {
      var version = await PackageInfo.fromPlatform();
      Logger().d("appVersion = ${response.getData()}, currentVersion = ${version.version}");
      var currentVersion = Version.parse(version.version);
      if (currentVersion < Version.parse(response.getData().requiredVersion)) {
        await _showRequiredUpdateDialog();
      }
      if (currentVersion < Version.parse(response.getData().latestVersion)) {
        await _showLatestUpdateDialog();
      }
    }
    return _isSignInUseCase();
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

  Future<void> _showRequiredUpdateDialog() async {
    await Get.dialog(
        AlertDialog(
          title: const Text('필수 업데이트가 있습니다'),
          content: const Text('업데이트 후 이용하실 수 있습니다'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                LaunchReview.launch();
                exit(0);
              },
              child: const Text('업데이트'),
            ),
            TextButton(
              onPressed: () => exit(0),
              child: const Text('취소'),
            ),
          ],
        ),
        barrierDismissible: false
    );
  }

  Future<void> _showLatestUpdateDialog() async {
    await Get.dialog(
        AlertDialog(
          title: const Text('업데이트가 있습니다'),
          content: const Text('최신 버전으로 업데이트 할 수 있습니다'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
                LaunchReview.launch();
              },
              child: const Text('업데이트'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('취소'),
            ),
          ],
        ),
        barrierDismissible: true
    );
  }
}
