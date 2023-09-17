import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tour_apps/admin/upcoming/bookingnotificationscreen.dart';

import '../../user/widget/showcontrapage.dart';

class LocalServiceNotfication {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initializeAdmin(BuildContext context) {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingNotificationScreen(
                userId: payload!,
              ),
            ));
      },
    );
  }

  static void initializeuser(BuildContext context) {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowCogrationlationPage(
                productId: payload!,
              ),
            ));
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      AndroidNotificationDetails androidNotificationDetails =
          const AndroidNotificationDetails(
        "tourapp",
        "tourapp",
        importance: Importance.high,
        priority: Priority.high,
      );
      NotificationDetails details =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
          50, message.notification!.title, message.notification!.body, details,
          payload: message.data['data']);
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
