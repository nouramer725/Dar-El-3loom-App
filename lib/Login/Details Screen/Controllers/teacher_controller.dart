import 'dart:io';
import 'package:dar_el_3loom/Model/parent_login_model.dart';
import 'package:dar_el_3loom/Model/teacher_login_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TeacherController extends ChangeNotifier {
  TeacherController({Teacher? teacher}) {
    if (teacher != null) {
      _loadStudentData(teacher);
    }
    loading = false;
    notifyListeners();
  }

  final id = TextEditingController();
  final name = TextEditingController();
  final nameMada = TextEditingController();
  final phoneParent = TextEditingController();
  final personalId = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool idLocked = false;
  bool nameLocked = false;
  bool nameMadaLocked = false;
  bool phoneParentLocked = false;
  bool personalIdLocked = false;
  bool passwordLocked = false;
  bool confirmPasswordLocked = false;

  File? personalImage;

  String? personalImageUrl;

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

  void _loadStudentData(Teacher teacher) {
    id.text = (hasValidValue(teacher.code) ? teacher.code : '')!;
    name.text = (hasValidValue(teacher.nMod) ? teacher.nMod : '')!;
    nameMada.text = (hasValidValue(teacher.nMada) ? teacher.nMada : '')!;
    phoneParent.text = (hasValidValue(teacher.phonenumber)
        ? teacher.phonenumber
        : '')!;
    personalId.text = (hasValidValue(teacher.personalId)
        ? teacher.personalId
        : '')!;
    personalImageUrl = buildImageUrl(teacher.personalImage);

    // Lock fields if already have data
    if (id.text.isNotEmpty) idLocked = true;
    if (name.text.isNotEmpty) nameLocked = true;
    if (nameMada.text.isNotEmpty) nameMadaLocked = true;
    if (phoneParent.text.isNotEmpty) phoneParentLocked = true;
    if (personalId.text.isNotEmpty) personalIdLocked = true;
    if (password.text.isNotEmpty) {
      passwordLocked = true;
      confirmPasswordLocked = true;
    }
  }

  Future<void> pickImage(bool isBirth) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      personalImage = File(image.path);
      personalImageUrl = null;
      notifyListeners();
    }
  }

  Map<String, dynamic> buildUpdateRequest() {
    final data = <String, dynamic>{};

    if (!idLocked) data['code'] = id.text;
    if (!nameLocked) data['n_mod'] = name.text;
    if (!nameMadaLocked) data['n_mada'] = nameMada.text;
    if (!phoneParentLocked) data['phonenumber'] = phoneParent.text;
    if (!personalIdLocked) data['personal_id'] = personalId.text;
    if (!passwordLocked) data['password'] = password.text;
    if (personalImage != null) data['personal_image'] = personalImage;
    return data;
  }

  bool loading = true;
}
