import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'const/const.dart';
import 'page/auth/loginpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: backgroundColor,
          titleTextStyle: appbarTextStyle,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: blueColor,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: white,
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
