import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/assistant_login_model.dart';
import 'app_flow.dart';

class AssistantLoginProvider with ChangeNotifier {
  AssistantLoginModel? _loginModel;

  List<Assistant> assistant = [];
  bool loading = false;
  Assistant? selectedAssistant;

  AssistantLoginModel? get loginModel => _loginModel;

  Assistant? get assistants => _loginModel?.data?.assistant;

  String? get token => _loginModel?.token;

  Future<void> setLoginAssistant(AssistantLoginModel model) async {
    _loginModel = model;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("assistant_login", jsonEncode(model.toJson()));

    if (model.token != null) {
      await AppFlow.saveAssistantToken(model.token!);
    }

    notifyListeners();
  }

  Future<void> loadAssistant() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("assistant_login");

    if (data != null) {
      _loginModel = AssistantLoginModel.fromJson(jsonDecode(data));
      notifyListeners();
    }
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("assistant_login");

    _loginModel = null;
    selectedAssistant = null;
    assistant = [];

    notifyListeners();
  }
}
