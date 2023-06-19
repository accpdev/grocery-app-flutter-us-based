// ignore_for_file: file_names

import 'dart:convert';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:egrocer/helper/styles/colorsRes.dart';
import 'package:egrocer/helper/utils/generalMethods.dart';
import 'package:egrocer/helper/utils/routeGenerator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';

class LocalAwesomeNotification {
  AwesomeNotifications notification = AwesomeNotifications();

  init(BuildContext context) {
    requestPermission();

    notification.initialize(
      'resource://mipmap/logo',
      [
        NotificationChannel(
          channelKey: Constant.notificationChannel,
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel',
          playSound: true,
          enableVibration: true,
          importance: NotificationImportance.High,
          ledColor: ColorsRes.appColor,
        )
      ],
      channelGroups: [],
    );
    listenTap(context);
  }

  @pragma('vm:entry-point')
  listenTap(BuildContext context) {
    try {
      AwesomeNotifications().setListeners(
          onNotificationCreatedMethod: (receivedNotification) async {},
          onActionReceivedMethod: (ReceivedAction event) async {
            Map<String, dynamic> data = jsonDecode(event.payload!["data"].toString());

            String notificationTypeId = data["id"];
            String notificationType = data["type"];

            Future.delayed(
              Duration.zero,
              () {
                if (notificationType == "default" || notificationType == "user") {
                  if (currentRoute != notificationListScreen) {
                    Navigator.pushNamed(Constant.navigatorKay.currentContext!, notificationListScreen);
                  }
                } else if (notificationType == "category") {
                  Navigator.pushNamed(Constant.navigatorKay.currentContext!, productListScreen, arguments: ["category", notificationTypeId.toString(), getTranslatedValue(Constant.navigatorKay.currentContext!, "lblAppName")]);
                } else if (notificationType == "product") {
                  Navigator.pushNamed(Constant.navigatorKay.currentContext!, productDetailScreen, arguments: [notificationTypeId.toString(), getTranslatedValue(Constant.navigatorKay.currentContext!, "lblAppName"), null]);
                } else if (notificationType == "url") {
                  launchUrl(Uri.parse(notificationTypeId.toString()), mode: LaunchMode.externalApplication);
                }
              },
            );
          });
    } catch (e, st) {
      print(st.toString());
    }
  }

  @pragma('vm:entry-point')
  createImageNotification({required RemoteMessage notificationData, required bool isLocked}) async {
    try {
      Map<String, dynamic> data = jsonDecode(notificationData.data["data"].toString());
      await notification.createNotification(
        content: NotificationContent(
          id: Random().nextInt(5000),
          color: ColorsRes.appColor,
          title: data["title"],
          locked: isLocked,
          payload: Map.from(notificationData.data),
          autoDismissible: true,
          showWhen: true,
          notificationLayout: NotificationLayout.BigPicture,
          body: data["message"],
          wakeUpScreen: true,
          largeIcon: data["image"],
          bigPicture: data["image"],
          channelKey: Constant.notificationChannel,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @pragma('vm:entry-point')
  createNotification({required RemoteMessage notificationData, required bool isLocked}) async {
    try {
      Map<String, dynamic> data = jsonDecode(notificationData.data["data"].toString());
      await notification.createNotification(
        content: NotificationContent(
          id: Random().nextInt(5000),
          color: ColorsRes.appColor,
          title: data["title"],
          locked: isLocked,
          payload: Map.from(notificationData.data),
          autoDismissible: true,
          showWhen: true,
          notificationLayout: NotificationLayout.Default,
          body: data["message"],
          wakeUpScreen: true,
          channelKey: Constant.notificationChannel,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @pragma('vm:entry-point')
  requestPermission() async {
    NotificationSettings notificationSettings = await FirebaseMessaging.instance.getNotificationSettings();

    if (notificationSettings.authorizationStatus == AuthorizationStatus.notDetermined) {
      await notification.requestPermissionToSendNotifications(
        channelKey: Constant.notificationChannel,
        permissions: [NotificationPermission.Alert, NotificationPermission.Sound, NotificationPermission.Badge, NotificationPermission.Vibration, NotificationPermission.Light],
      );

      if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized || notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {}
    } else if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }
  }
}
