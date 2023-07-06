import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'const/const.dart';
import 'splashscreen/splashpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: backgroundColor,
          titleTextStyle: appbarTextStyle,
          elevation: 0.0,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: blueColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
