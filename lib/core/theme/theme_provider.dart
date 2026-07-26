import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = "isDarkMode";
  final SharedPreferences _prefs;
  late bool _isDarkMode;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider(this._prefs) {
    _isDarkMode = _prefs.getBool(_themeKey) ?? false;
  }

  void toggleTheme(bool value) async {
    _isDarkMode = value;
    notifyListeners();
    await _prefs.setBool(_themeKey, _isDarkMode);
  }
}
