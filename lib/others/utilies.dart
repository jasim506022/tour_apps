import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tour_apps/service/provider/themeprovider.dart';


class Utils {
  BuildContext context;
  Utils(this.context);

  Size get getScreenSize => MediaQuery.of(context).size;
  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  Color get getColor => getTheme ? Colors.black : Colors.white;

  Color get baseShimmerColor =>
      getTheme ? const Color.fromARGB(255, 92, 123, 127) : Colors.grey.shade200;

  Color get highlightShimmerColor => getTheme
      ? const Color.fromARGB(255, 108, 140, 145)
      : Colors.grey.shade400;

  Color get widgetShimmerColor => getTheme
      ? const Color.fromARGB(255, 110, 139, 143)
      : Colors.grey.shade100;
}
