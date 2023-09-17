import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'globalmethod.dart';

SharedPreferences? prefs;

int? isviewed;

GlobalMethod globalMethod = GlobalMethod();

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

enum DeleteUpdate { delete, update }

String fcmServiceToken =
    'key=AAAATfKE-Dw:APA91bG_mYnTzD9qwcAz4mOAUESv8SnHXxwxGImf1oAzP1F5yrVUkppgTmEKPLpkB0aYQ3tdeY3kgO-wrYgQ6nclRS614YryMc7i9zn_tM3ONhHhCL51acNgFVF9XqLvKVZ63NL5bzJi';
