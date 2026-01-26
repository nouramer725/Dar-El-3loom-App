import 'package:dar_el_3loom/provider/shared_preferences_theme.dart';
import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;

  AppThemeProvider() {
    appTheme = SharedPreferencesTheme.getTheme();
  }

  void changeTheme(ThemeMode newTheme) async {
    if (newTheme == appTheme) return;

    appTheme = newTheme;
    await SharedPreferencesTheme.setTheme(newTheme);
    notifyListeners();
  }

  bool isDarkTheme() => appTheme == ThemeMode.dark;
}
