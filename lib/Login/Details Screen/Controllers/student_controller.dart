import 'dart:io';
import 'package:dar_el_3loom/Model/student_login_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StudentController extends ChangeNotifier {
  StudentController({Student? student}) {
    if (student != null) {
      _loadStudentData(student);
    }
    loading = false;
    notifyListeners();
  }

  final code = TextEditingController();
  final name = TextEditingController();
  final level = TextEditingController();
  final phoneStudent = TextEditingController();
  final phoneParent = TextEditingController();
  final nationalId = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool codeLocked = false;
  bool nameLocked = false;
  bool phoneStudentLocked = false;
  bool phoneParentLocked = false;
  bool nationalIdLocked = false;
  bool passwordLocked = false;
  bool confirmPasswordLocked = false;
  bool levelLocked = false;

  File? birthImage;
  File? personalImage;

  String? birthImageUrl;
  String? personalImageUrl;

  String? selectedLevel;

  bool get hasBirthImage => birthImage != null || birthImageUrl != null;
  bool get hasPersonalImage =>
      personalImage != null || personalImageUrl != null;

  bool hasValidValue(String? v) {
    if (v == null) return false;
    final trimmed = v.trim();
    if (trimmed.isEmpty) return false;
    if (trimmed.toLowerCase() == 'string') return false;
    return true;
  }

  String? buildImageUrl(String? path) {
    if (!hasValidValue(path)) return null;

    if (path!.startsWith('http') || path.startsWith('https')) {
      return path;
    }

    const baseUrl = 'http://10.0.2.2:3000';
    if (path.startsWith('/')) {
      return '$baseUrl$path';
    } else {
      return '$baseUrl/$path';
    }
  }

  void _loadStudentData(Student student) {
    code.text = (hasValidValue(student.codTalb) ? student.codTalb : '')!;
    name.text = (hasValidValue(student.nTalb) ? student.nTalb : '')!;
    level.text = (hasValidValue(student.nSaf) ? student.nSaf : '')!;
    phoneStudent.text = (hasValidValue(student.tel)
        ? student.tel
        : '')!;
    phoneParent.text = (hasValidValue(student.tel1)
        ? student.tel1
        : '')!;
    nationalId.text = (hasValidValue(student.personalId)
        ? student.personalId
        : '')!;
    birthImageUrl = buildImageUrl(student.birthCertificate);
    personalImageUrl = buildImageUrl(student.profilePicture);

    // Lock fields if already have data
    if (code.text.isNotEmpty) codeLocked = true;
    if (name.text.isNotEmpty) nameLocked = true;
    if (level.text.isNotEmpty) levelLocked = true;
    if (phoneStudent.text.isNotEmpty) phoneStudentLocked = true;
    if (phoneParent.text.isNotEmpty) phoneParentLocked = true;
    if (nationalId.text.isNotEmpty) nationalIdLocked = true;
    if (password.text.isNotEmpty) {
      passwordLocked = true;
      confirmPasswordLocked = true;
    }
  }

  void setLevel(String value) {
    selectedLevel = value;
    level.text = value;
    notifyListeners();
  }

  Future<void> pickImage(bool isBirth) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      if (isBirth) {
        birthImage = File(image.path);
        birthImageUrl = null;
      } else {
        personalImage = File(image.path);
        personalImageUrl = null;
      }
      notifyListeners();
    }
  }

  Map<String, dynamic> buildUpdateRequest() {
    final data = <String, dynamic>{};

    if (!codeLocked) data['cod_talb'] = code.text;
    if (!nameLocked) data['n_talb'] = name.text;
    if (!levelLocked) data['n_saf'] = selectedLevel;
    if (!phoneStudentLocked) data['tel'] = phoneStudent.text;
    if (!phoneParentLocked) data['tel_1'] = phoneParent.text;
    if (!nationalIdLocked) data['personal_id'] = nationalId.text;
    if (!passwordLocked) data['password'] = password.text;

    if (birthImage != null) data['birth_certificate'] = birthImage;
    if (personalImage != null) data['profile_picture'] = personalImage;

    return data;
  }

  bool loading = true;
}
