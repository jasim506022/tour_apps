import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class MainScren extends StatefulWidget {
  const MainScren({super.key});

  @override
  State<MainScren> createState() => _MainScrenState();
}

class _MainScrenState extends State<MainScren> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String mtoken = "";
  TextEditingController username = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    // requestPermission();
    // getToken();
    getFcmToken();
    requestNotificationPermission();
    initInfo();
    super.initState();
  }

  String? token;

  Future<void> requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("Notification permission granted.");
    } else {
      print("Notification permission not granted.");
    }
  }

  Future<String> getFcmToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print(token);
    return token ?? '';
  }

  Future<void> sendNotification(
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
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
          },
        },
      ),
    );
  }


  initInfo() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {},
    );
    FirebaseMessaging.onMessage.listen((message) async {
      print(".......................on Message.....................");
      print(
          "On Message: ${message.notification!.title}/${message.notification!.body}");

      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true);
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails("dbfood", "dbfood",
              importance: Importance.high,
              styleInformation: bigTextStyleInformation,
              priority: Priority.high,
              playSound: true);

      NotificationDetails details =
          NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.show(
          0, message.notification!.title, message.notification!.body, details,
          payload: message.data['body']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              sendNotification("fstvdb2aSZ26bA8PynE8bb:APA91bFD8FayLbakuFKzh6pxIFhybeuuAe2dbOEIHK82uKKJXqAoQWsdzxOCgifTo30LsjS2Qeurrl_IzLYS8BeOnOB1rg4EKgJ6R1torskNUEq0WlEgl_555fMHah1yWCjv6WMm4SvW", "My nmae Is Rony What are you doing",
                  "What are you doing now");
            },
            child: const Text("Sent Notifications")),
      ),
    );
  }
}
