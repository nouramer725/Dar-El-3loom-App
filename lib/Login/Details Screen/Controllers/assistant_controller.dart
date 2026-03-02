import 'dart:io';
import 'package:dar_el_3loom/Model/assistant_login_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AssistantController extends ChangeNotifier {
  AssistantController({Assistant? assistant}) {
    if (assistant != null) {
      _loadStudentData(assistant);
    }
    loading = false;
    notifyListeners();
  }

  final id = TextEditingController();
  final name = TextEditingController();
  final nameTeacher = TextEditingController();
  final nameMada = TextEditingController();
  final phoneParent = TextEditingController();
  final personalId = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool idLocked = false;
  bool nameLocked = false;
  bool nameTeacherLocked = false;
  bool nameMadaLocked = false;
  bool phoneParentLocked = false;
  bool personalIdLocked = false;
  bool passwordLocked = false;
  bool confirmPasswordLocked = false;

  File? personalImage;
  File? birthdayCertificate;

  String? personalImageUrl;
  String? birthdayCertificateUrl;

  bool get hasPersonalImage =>
      personalImage != null || personalImageUrl != null;

  bool get hasBirthdayCertificate =>
      birthdayCertificate != null || birthdayCertificateUrl != null;

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

  void _loadStudentData(Assistant assistant) {
    id.text = (hasValidValue(assistant.code) ? assistant.code : '')!;
    name.text = (hasValidValue(assistant.name) ? assistant.name : '')!;
    nameMada.text = (hasValidValue(assistant.nMada) ? assistant.nMada : '')!;
    nameTeacher.text = (hasValidValue(assistant.nMod) ? assistant.nMod : '')!;
    phoneParent.text = (hasValidValue(assistant.phonenumber)
        ? assistant.phonenumber
        : '')!;
    personalId.text = (hasValidValue(assistant.personalId)
        ? assistant.personalId
        : '')!;
    personalImageUrl = buildImageUrl(assistant.personalImage);
    birthdayCertificateUrl = buildImageUrl(assistant.birthdayCertificate);

    // Lock fields if already have data
    if (id.text.isNotEmpty) idLocked = true;
    if (name.text.isNotEmpty) nameLocked = true;
    if (nameTeacher.text.isNotEmpty) nameTeacherLocked = true;
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
      if (isBirth) {
        birthdayCertificate = File(image.path);
        birthdayCertificateUrl = null;
      } else {
        personalImage = File(image.path);
        personalImageUrl = null;
      }
      notifyListeners();
    }
  }

  Map<String, dynamic> buildUpdateRequest() {
    final data = <String, dynamic>{};

    if (!idLocked) data['code'] = id.text;
    if (!nameLocked) data['name'] = name.text;
    if (!nameTeacherLocked) data['teacher_name'] = nameTeacher.text;
    if (!nameMadaLocked) data['n_mada'] = nameMada.text;
    if (!phoneParentLocked) data['phonenumber'] = phoneParent.text;
    if (!personalIdLocked) data['personal_id'] = personalId.text;
    if (!passwordLocked) data['password'] = password.text;
    if (birthdayCertificate != null) data['birthday_certificate'] = birthdayCertificate;
    if (personalImage != null) data['personal_image'] = personalImage;

    return data;
  }

  bool loading = true;
}
