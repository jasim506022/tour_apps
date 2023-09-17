import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../admin/upcoming/bookingnotificationscreen.dart';
import '../../others/const.dart';
import '../../user/widget/showcontrapage.dart';
import 'local_service.dart';
import 'package:http/http.dart' as http;

class PushNotificationMessage {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<void> requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("Notification permission granted.");
      }
    } else {
      if (kDebugMode) {
        print("Notification permission not granted.");
      }
    }
  }

  initMessageInforAdmin(BuildContext context) {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookingNotificationScreen(
                userId: message.data['userid'],
              ),
            ));
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      LocalServiceNotfication.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data['data'];

      if (kDebugMode) {
        print(routeFromMessage);
      }
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingNotificationScreen(
              userId: message.notification!.body!,
            ),
          ));
    });
  }

//user
  initMessageInforUser(BuildContext context) {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowCogrationlationPage(
                productId: message.data['data'],
              ),
            ));
      }
    });

    FirebaseMessaging.onMessage.listen((message) {
      LocalServiceNotfication.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data['data'];
      if (kDebugMode) {
        print(routeFromMessage);
      }
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookingNotificationScreen(
              userId: message.notification!.body!,
            ),
          ));
    });
  }

//user
  Future<void> sendNotificationUser(
      String receiverToken, String title, String body, String data) async {
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': fcmServiceToken,
        },
        body: jsonEncode(
          <String, dynamic>{
            'to': receiverToken,
            'data': <String, dynamic>{
              // Custom data
              'title': title,
              'body': body,
              'data': data
            },
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
            },
          },
        ));
  }

//admin
  Future<void> sendNotificationAdmin(
      String receiverToken, String title, String body) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAATfKE-Dw:APA91bG_mYnTzD9qwcAz4mOAUESv8SnHXxwxGImf1oAzP1F5yrVUkppgTmEKPLpkB0aYQ3tdeY3kgO-wrYgQ6nclRS614YryMc7i9zn_tM3ONhHhCL51acNgFVF9XqLvKVZ63NL5bzJi', // Replace with your server key
      },
      body: jsonEncode(
        <String, dynamic>{
          'to': receiverToken,
          'data': <String, dynamic>{
            // Custom data
            'title': title,
            'body': body,
            
          },
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
          },
        },
      ),
    );
  }
}
