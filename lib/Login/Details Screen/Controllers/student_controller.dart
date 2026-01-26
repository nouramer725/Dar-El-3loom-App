import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Api/student_api.dart';

class StudentController extends ChangeNotifier {
  final StudentRepository repository;

  StudentController(this.repository);

  String? selectedLevel;

  List<String> levels = [
    "الصف الأول الابتدائي",
    "الصف الثاني الابتدائي",
    "الصف الثالث الابتدائي",
    "الصف الرابع الابتدائي",
    "الصف الخامس الابتدائي",
    "الصف السادس الابتدائي",
    "الصف الأول الإعدادي",
    "الصف الثاني الإعدادي",
    "الصف الثالث الإعدادي",
    "الصف الأول الثانوي",
    "الصف الثاني الثانوي",
    "الصف الثالث الثانوي",
  ];


  // Controllers
  final name = TextEditingController();
  final level = TextEditingController();
  final phoneStudent = TextEditingController();
  final phoneParent = TextEditingController();
  final nationalId = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();


  // Locks
  bool nameLocked = false;
  bool phoneStudentLocked = false;
  bool phoneParentLocked = false;
  bool nationalIdLocked = false;
  bool passwordLocked = false;
  bool confirmPasswordLocked = false;
  bool levelLocked = false;



  bool loading = true;

  // Images
  File? birthImage;
  File? personalImage;


  Future loadStudentData() async {
    final data = await repository.getStudentData();

    if (data.name != null && data.name!.isNotEmpty) {
      name.text = data.name!;
      nameLocked = true;
    }

    if (data.level != null && data.level!.isNotEmpty) {
      level.text = data.level!;
      levelLocked = true;
    }

    if (data.phoneStudent != null && data.phoneStudent!.isNotEmpty) {
      phoneStudent.text = data.phoneStudent!;
      phoneStudentLocked = true;
    }

    if (data.phoneParent != null && data.phoneParent!.isNotEmpty) {
      phoneParent.text = data.phoneParent!;
      phoneParentLocked = true;
    }

    if (data.nationalId != null && data.nationalId!.isNotEmpty) {
      nationalId.text = data.nationalId!;
      nationalIdLocked = true;
    }

    if (data.password != null && data.password!.isNotEmpty) {
      password.text = data.password!;
      passwordLocked = true;
    }

    if (data.confirmPassword != null && data.confirmPassword!.isNotEmpty) {
      confirmPassword.text = data.confirmPassword!;
      confirmPasswordLocked = true;
    }


    loading = false;
    notifyListeners();
  }

  void setLevel(String value) {
    selectedLevel = value;
    notifyListeners();
  }


  Future pickImage(bool isBirth) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);


    if (image != null) {
      if (isBirth) {
        birthImage = File(image.path);
      } else {
        personalImage = File(image.path);
      }
      notifyListeners();
    }
  }
}
