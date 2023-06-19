// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'awsomeNotification.dart';

class NotificationService {
  static FirebaseMessaging messagingInstance = FirebaseMessaging.instance;

  static LocalAwesomeNotification localNotification = LocalAwesomeNotification();

  static late StreamSubscription<RemoteMessage> foregroundStream;
  static late StreamSubscription<RemoteMessage> onMessageOpen;

  static requestPermission() async {

  }

  static init(context) {
    requestPermission();
    registerListeners(context);
  }

  @pragma('vm:entry-point')
  static Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
    Map<String, dynamic> data = jsonDecode(message.data["data"].toString());
    if (data["image"] == "" || data["image"] == null) {
      localNotification.createNotification(isLocked: false, notificationData: message);
    } else {
      localNotification.createImageNotification(isLocked: false, notificationData: message);
    }
  }

  @pragma('vm:entry-point')
  static foregroundNotificationHandler() async {
    foregroundStream = FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      try {
        Map<String, dynamic> data = jsonDecode(message.data["data"].toString());
        if (data["image"] == "" || data["image"] == null) {
          log("notification came while app open");
          localNotification.createNotification(isLocked: false, notificationData: message);
        } else {
          log("image notification came while app open");
          localNotification.createImageNotification(isLocked: false, notificationData: message);
        }
      } catch (e) {
        print("ISSUE ${e.toString()}");
      }
    });
  }

  @pragma('vm:entry-point')
  static terminatedStateNotificationHandler() {
    FirebaseMessaging.instance.getInitialMessage().then(
      (RemoteMessage? message) {
        if (message == null) {
          return;
        }
        Map<String, dynamic> data = jsonDecode(message.data["data"].toString());
        if (data["image"] == "" || data["image"] == null) {
          localNotification.createNotification(isLocked: false, notificationData: message);
        } else {
          localNotification.createImageNotification(isLocked: false, notificationData: message);
        }
      },
    );
  }

  @pragma('vm:entry-point')
  static onTapNotificationHandler(context) {
    onMessageOpen = FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        // if (message.data["screen"] == "profile") {
        //   Navigator.pushNamed(context, profileRoute);
        // }
      },
    );
  }

  @pragma('vm:entry-point')
  static registerListeners(context) async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);
    await foregroundNotificationHandler();
    await terminatedStateNotificationHandler();
    await onTapNotificationHandler(context);
  }

  @pragma('vm:entry-point')
  static disposeListeners() {
    onMessageOpen.cancel();
    foregroundStream.cancel();
  }
}
