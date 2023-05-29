import 'package:flutter/material.dart';
import 'package:tour_apps/page/exployerpage.dart';
import 'package:tour_apps/page/homepage.dart';
import 'package:tour_apps/page/itemdetailspage.dart';
import 'package:tour_apps/page/loginpage.dart';
import 'package:tour_apps/page/registrationpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff008FA0)),
        primaryColor: const Color(0xff008FA0),
        useMaterial3: true,
      ),
      home: const ItemDetailsPage(),
    );
  }
}
