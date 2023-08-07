import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../auth/loginpage.dart';
import '../../admin/adminmainpage.dart';
import '../../user/mainpage.dart';

class SplashService {
  void isMainPage(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      if (user.uid == "Uq4kPlNYbTUqqqQNUMWTOm7ifzD3") {
        Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminMainPage(),
              )),
        );
      } else {
        Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              )),
        );
      }
    } else {
      Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            )),
      );
    }
  }
}
