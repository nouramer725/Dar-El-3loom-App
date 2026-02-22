import 'dart:convert';
import 'package:dar_el_3loom/Model/parent_login_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_flow.dart';

class ParentLoginProvider with ChangeNotifier {
  ParentLoginModel? _loginModel;

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
}
