import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/student_model.dart';

class StudentProvider extends ChangeNotifier {
  StudentModel? _student;

  StudentModel? get student => _student;

  Future<void> setStudent(StudentModel newStudent) async {
    _student = newStudent;
    notifyListeners();
    await _saveToPrefs(newStudent);
  }

  Future<void> clearStudent() async {
    _student = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('student');
  }

  Future<void> loadStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('student');
    if (jsonString != null) {
      final jsonData = json.decode(jsonString);
      _student = StudentModel.fromJson(jsonData);
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs(StudentModel student) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(student.toJson());
    await prefs.setString('student', jsonString);
  }
}
