import 'package:dar_el_3loom/utils/pref_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTheme {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static ThemeMode getTheme() {
    final theme = sharedPreferences.getString(PrefKeys.themeKey);

    if (theme == 'dark') return ThemeMode.dark;
    if (theme == 'light') return ThemeMode.light;

    return ThemeMode.light;
  }

  static Future<void> setTheme(ThemeMode theme) async {
    await sharedPreferences.setString(PrefKeys.themeKey, theme.name);
  }

  ///App Flow functions
  static String? getUserStep() {
    return sharedPreferences.getString(PrefKeys.userStepKey);
  }

  static Future<void> setUserStep(String step) async {
    await sharedPreferences.setString(PrefKeys.userStepKey, step);
  }

  static Future<void> clearUserStep() async {
    await sharedPreferences.remove(PrefKeys.userStepKey);
  }
}
