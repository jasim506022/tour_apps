import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Colors
Color backgroundColor = const Color.fromRGBO(247, 247, 247, 1);
Color blueColor = const Color.fromRGBO(0, 143, 160, 1);
Color unselectedColor = const Color.fromRGBO(30, 30, 30, 1);
Color iconColor = const Color.fromRGBO(61, 61, 61, 1);
Color locationTextColor = const Color.fromRGBO(20, 20, 20, 1);
Color yello = const Color.fromRGBO(255, 210, 51, 1);
Color white = Colors.white;
Color black = const Color.fromRGBO(30, 30, 30, 1);

SharedPreferences? prefs;

showToast({required BuildContext context, required String text}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Theme.of(context).primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

// TextStyle
TextStyle textStyle = GoogleFonts.inter(
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    color: unselectedColor);

TextStyle textStylemontserrat = GoogleFonts.inter(
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    color: unselectedColor);

TextStyle categoryTitle = GoogleFonts.inter(
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    color: black);

TextStyle tourplacetextSTyle = GoogleFonts.inter(
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    color: blueColor);

TextStyle appbarTextStyle = GoogleFonts.inter(
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
    color: black);

enum DeleteUpdate { delete, update }
