import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/student_login_provider.dart';
import '../provider/parent_login_provider.dart';
import '../utils/app_routes.dart';

class AppFlow {
  static String getInitialRoute(BuildContext context) {
    final studentProvider = Provider.of<StudentLoginProvider>(
      context,
      listen: false,
    );
    final parentProvider = Provider.of<ParentLoginProvider>(
      context,
      listen: false,
    );

    final student = studentProvider.student;
    final studentToken = studentProvider.token;

    final parent = parentProvider.loginModel?.data?.parent;
    final parentToken = parentProvider.token;

    if (student != null && studentToken != null) {
      if (student.verified != true) {
        return AppRoutes.detailsScreen;
      }
      return AppRoutes.homeScreenName;
    }

    if (parent != null && parentToken != null) {
      if (parent.verified != true) {
        return AppRoutes.detailsParentScreen;
      }
      return AppRoutes.homeParentScreenName;
    }

    return AppRoutes.firstTimeLoginScreenName;
  }

  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (context.mounted) {
      Provider.of<StudentLoginProvider>(context, listen: false).clear();
      Provider.of<ParentLoginProvider>(context, listen: false).clear();

      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginScreen,
        (route) => false,
      );
    }
  }

  /// Save token for Student
  static Future<void> saveStudentToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('student_token', token);
  }

  /// Get token for Student
  static Future<String?> getStudentToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('student_token');
  }

  /// Save token for Parent
  static Future<void> saveParentToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('parent_token', token);
  }

  /// Get token for Parent
  static Future<String?> getParentToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('parent_token');
  }
}
