import '../Model/student_model.dart';

abstract class StudentRepository {
  Future<StudentModel> getStudentData();
}

class StudentRepositoryImpl implements StudentRepository {
  @override
  Future<StudentModel> getStudentData() async {
    await Future.delayed(Duration(seconds: 2));

    return StudentModel(
      name: "Ahmed Ali",
      level: "",
      phoneStudent: "01012345678",
      phoneParent: "",
      nationalId: "30212345678901",
      password: "",
      confirmPassword: "",
      birthImage: "",
      studentImage: "",
    );
  }
}
