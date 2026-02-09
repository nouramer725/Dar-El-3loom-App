import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/student_login_provider.dart';
import '../utils/app_routes.dart';

class AppFlow {
  static String getInitialRoute(BuildContext context) {
    final loginProvider = Provider.of<StudentLoginProvider>(
      context,
      listen: false,
    );

    final student = loginProvider.student;
    final token = loginProvider.token;

    /// Not logged in at all
    if (student == null || token == null) {
      return AppRoutes.firstTimeLoginScreenName;
    }

    /// Logged but profile not completed
    if (student.verified != true) {
      return AppRoutes.detailsScreen;
    }

    /// Fully logged in
    return AppRoutes.homeScreenName;
  }

  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();

    if (context.mounted) {
      Provider.of<StudentLoginProvider>(context, listen: false).clear();

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginScreen,
        (route) => false,
      );
    }
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
