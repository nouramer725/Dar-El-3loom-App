import 'package:dio/dio.dart';
import '../../Login/Details Screen/Model/student_model.dart';

class ApiService {
  late Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:3000',
        headers: {'Content-Type': 'application/json'},
      ),
    );
  }

  Future<Map<String, dynamic>> verifyStudent({
    required String code,
    required String parentNumber,
  }) async {
    final response = await dio.post(
      '/api/v1/students/verify',
      data: {"cod_talb": code, "tel_1": parentNumber},
    );
    print(response.data);
    return response.data;
  }


  Future<Map<String, dynamic>> updateStudentInfo(StudentModel student) async {
    FormData formData = FormData.fromMap({
      "cod_talb": student.code,
      "n_talb": student.name,
      "n_saf": student.level,
      "tel": student.phoneStudent,
      "tel_1": student.phoneParent,
      "personal_id": student.nationalId,
      "password": student.password,
    });

    if (student.birthImage != null && student.birthImage!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "birth_certificate",
          await MultipartFile.fromFile(student.birthImage!),
        ),
      );
    }

    if (student.studentImage != null && student.studentImage!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "profile_picture",
          await MultipartFile.fromFile(student.studentImage!),
        ),
      );
    }

    final response = await dio.patch(
      '/api/v1/students/${student.code}',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );

    return response.data;
  }


  Future<Map<String, dynamic>> login({
    required String code,
    required String password,
  }) async {
    final response = await dio.post(
      '/api/v1/students/login',
      data: {"cod_talb": code, "password": password},
    );
    return response.data;
  }
}
