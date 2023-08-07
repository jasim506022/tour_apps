import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHelper {
  static FirebaseMessaging fmessaging = FirebaseMessaging.instance;

  static Future<void> getFirebaseMessagingToken() async {
    // Request permission for FCM (optional, only needed for iOS)
    await fmessaging.requestPermission();

    // Get the FCM token
    String? token = await fmessaging.getToken();
    
    if (token != null) {
      // Store the FCM token in your desired location (e.g., user's database)
      print(token);
    }
  }
}

