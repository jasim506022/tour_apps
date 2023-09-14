import 'package:flutter/material.dart';
import '../others/const.dart';
import '../others/textstyle.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    globalMethod.isMainPage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "asset/image/ion_earth400.png",
            height: 150,
            width: 150,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Tour Apps",
            style: appbarTextStyle,
          )
        ],
      ),
    );
  }
}
