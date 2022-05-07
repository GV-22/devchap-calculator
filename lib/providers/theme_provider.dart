//theme_model.dart 
import 'package:calculator/utils/theme_preferences.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  late bool _isDark;
  late ThemePreferences _preferences;

  ThemeProvider() {
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
  }
  
  bool get isDark => _isDark;
  
  //Switching themes in the flutter apps - Flutterant
  Future<void> setDarkMode(bool value) async {
    _isDark = value;
    await _preferences.setTheme(value);
    notifyListeners();
  }

  Future<void> getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}
//Switching themes in the flutter apps - Flutterant