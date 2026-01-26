import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTheme {
  static const String _themeKey = 'app_theme';

  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static ThemeMode getTheme() {
    final theme = sharedPreferences.getString(_themeKey);

    if (theme == 'dark') return ThemeMode.dark;
    if (theme == 'light') return ThemeMode.light;

    return ThemeMode.light;
  }


  static Future<void> setTheme(ThemeMode theme) async {
    await sharedPreferences.setString(_themeKey, theme.name);
  }
}
