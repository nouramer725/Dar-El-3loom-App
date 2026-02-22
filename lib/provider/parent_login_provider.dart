import 'dart:convert';
import 'package:dar_el_3loom/Model/parent_login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../BackendSetup Data/Api/api_service.dart';
import '../Model/student_login_model.dart';
import 'app_flow.dart';

class ParentLoginProvider with ChangeNotifier {
  ParentLoginModel? _loginModel;

  List<Student> children = [];
  bool loading = false;

  ParentLoginModel? get loginModel => _loginModel;

  Parent? get student => _loginModel?.data?.parent;

  String? get token => _loginModel?.token;

  Future<void> setLoginParent(ParentLoginModel model) async {
    _loginModel = model;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("parent_login", jsonEncode(model.toJson()));

    // ✅ Save token separately for easier access
    if (model.token != null) {
      await AppFlow.saveParentToken(model.token!);
    }

    notifyListeners();
  }

  Future<void> loadParent() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString("parent_login");

    if (data != null) {
      _loginModel = ParentLoginModel.fromJson(jsonDecode(data));
      notifyListeners();
    }
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("parent_login");

    _loginModel = null;

    notifyListeners();
  }


  Future<void> fetchChildren() async {
    loading = true;
    notifyListeners();

    final api = ApiService(token: token);
    children = await api.getChildren();

    loading = false;
    notifyListeners();
  }
}
