import 'dart:convert';
import 'package:dar_el_3loom/Model/teacher_login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_flow.dart';

class TeacherLoginProvider with ChangeNotifier {
  TeacherLoginModel? _loginModel;

  List<Teacher> teacher = [];
  bool loading = false;
  Teacher? selectedTeacher;

  TeacherLoginModel? get loginModel => _loginModel;

  Teacher? get teachers => _loginModel?.data?.teacher;

  String? get token => _loginModel?.token;

  Future<void> setLoginTeacher(TeacherLoginModel model) async {
    _loginModel = model;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("teacher_login", jsonEncode(model.toJson()));

    if (model.token != null) {
      await AppFlow.saveTeacherToken(model.token!);
    }

    notifyListeners();
  }

  Future<void> loadTeacher() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("teacher_login");

    if (data != null) {
      _loginModel = TeacherLoginModel.fromJson(jsonDecode(data));
      notifyListeners();
    }
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("teacher_login");

    _loginModel = null;
    selectedTeacher = null;
    teacher = [];

    notifyListeners();
  }
}
