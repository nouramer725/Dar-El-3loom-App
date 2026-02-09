import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/student_login_model.dart';
import 'app_flow.dart';

class StudentLoginProvider with ChangeNotifier {
  StudentLoginModel? _loginModel;

  StudentLoginModel? get loginModel => _loginModel;

  Student? get student => _loginModel?.data?.student;

  String? get token => _loginModel?.token;

  Future<void> setLogin(StudentLoginModel model) async {
    _loginModel = model;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("student_login", jsonEncode(model.toJson()));

    // ✅ Save token separately for easier access
    if (model.token != null) {
      await AppFlow.saveToken(model.token!);
    }

    notifyListeners();
  }

  Future<void> loadStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("student_login");

    if (data != null) {
      _loginModel = StudentLoginModel.fromJson(jsonDecode(data));
      notifyListeners();
    }
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("student_login");

    _loginModel = null;

    notifyListeners();
  }
}
