import 'package:flutter/foundation.dart';

import '../other/themepreferences.dart';


class ThemeProvider with ChangeNotifier {
  ThemePreferences darkThemePreference = ThemePreferences();

  bool _darkTheme = false;

  bool get getDarkTheme => _darkTheme;

  set setDarkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
