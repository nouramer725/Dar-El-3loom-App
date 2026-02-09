import 'dart:io';

import 'package:dar_el_3loom/Model/mozakrat_model.dart';
import 'package:dar_el_3loom/Model/student_login_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  late Dio dio;

  ApiService({String? token}) {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:3000',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
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

  Future<Map<String, dynamic>> updateStudentInfo(Student student) async {
    FormData formData = FormData.fromMap({
      "cod_talb": student.codTalb,
      "n_talb": student.nTalb,
      "n_saf": student.nSaf,
      "tel": student.tel,
      "tel_1": student.tel1,
      "personal_id": student.personalId,
      "verified": student.verified,
      "password": student.password,
    });

    if (student.birthCertificate != null &&
        student.birthCertificate!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "birth_certificate",
          await MultipartFile.fromFile(student.birthCertificate!),
        ),
      );
    }

    if (student.profilePicture != null && student.profilePicture!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "profile_picture",
          await MultipartFile.fromFile(student.profilePicture!),
        ),
      );
    }

    final response = await dio.patch(
      '/api/v1/students/${student.codTalb}',
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

  Future<Map<String, dynamic>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await dio.post(
      '/api/v1/students/change-password',
      data: {"oldPassword": oldPassword, "newPassword": newPassword},
    );

    return response.data;
  }

  Future<Map<String, dynamic>> uploadProfilePicture(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        'profile_picture': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        '/api/v1/students/profile-picture',
        data: formData,
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        // لو السيرفر رجع رسالة خطأ
        return e.response!.data;
      } else {
        return {'status': 'fail', 'message': e.message};
      }
    } catch (e) {
      return {'status': 'fail', 'message': e.toString()};
    }
  }

  Future<List<Mozakrat>> fetchMozakrat({String filter = 'all'}) async {
    try {
      final response = await dio.get(
        '/api/v1/mozakrat',
        options: Options(headers: {'filter': filter}),
      );

      if (response.data['status'] == 'success') {
        List mozakratList = response.data['data']['mozakrat'] ?? [];
        return mozakratList.map((e) => Mozakrat.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching mozakrat: $e");
      return [];
    }
  }
}
