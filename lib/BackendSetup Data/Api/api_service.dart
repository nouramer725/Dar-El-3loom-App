import 'dart:io';
import 'package:dar_el_3loom/Model/mozakrat_model.dart';
import 'package:dar_el_3loom/Model/student_login_model.dart';
import 'package:dio/dio.dart';
import '../../Model/balance_model.dart';
import '../../Model/lessons_date_model.dart';
import '../../Model/student_time_model.dart';
import '../../Model/takim_model.dart';

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

  // Fetch subjects and teachers for the student
  Future<List<Map<String, dynamic>>> fetchSubjects() async {
    try {
      final response = await dio.get('/api/v1/schedule/subjects');
      if (response.data['status'] == 'success') {
        List subjects = response.data['data']['subjects'] ?? [];
        return List<Map<String, dynamic>>.from(subjects);
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching subjects: $e");
      return [];
    }
  }

  // Fetch detailed schedule for a subject, teacher, month, year
  Future<Map<String, dynamic>?> fetchScheduleDetails({
    required String subject,
    required String teacher,
    required int month,
    int? year,
  }) async {
    try {
      final response = await dio.get(
        '/api/v1/schedule/details',
        queryParameters: {
          'subject': subject,
          'teacher': teacher,
          'month': month,
          'year': year ?? DateTime.now().year,
        },
      );
      if (response.data['status'] == 'success') {
        return response.data['data'];
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching schedule details: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchBalanceFilters() async {
    final response = await dio.get("/api/v1/madfoaat/teachers");

    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<List<BalanceModel>> fetchBalanceDetails({
    String? subject,
    String? teacher,
    String? status,
  }) async {
    final response = await dio.get(
      "/api/v1/madfoaat",
      queryParameters: {
        if (subject != null) "subject": subject,
        if (teacher != null) "teacher": teacher,
        if (status != null) "status": status,
      },
    );

    final data = response.data['data'] as List;

    return data.map((e) => BalanceModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> fetchTakiim({required int month}) async {
    try {
      final response = await dio.get(
        "/api/v1/takrer",
        queryParameters: {"month": month},
      );

      if (response.data['status'] == 'success') {
        final takiimJson = response.data['data']['takiim'] as List;
        final totalsJson = response.data['data']['totals'];

        List<TakiimModel> takiimList = takiimJson
            .map((e) => TakiimModel.fromJson(e))
            .toList();

        return {"takiim": takiimList, "totals": totalsJson};
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching takiim: $e");
      return null;
    }
  }

  Future<List<String>> fetchScheduleSubjects() async {
    final response = await dio.get("/api/v1/schedule-dates");

    final data = response.data['data'] as List;

    return data.map<String>((e) => e['n_mada'].toString()).toSet().toList();
  }

  Future<List<StudentDateModel>> fetchScheduleDatesDetails({
    required String subject,
    required String type,
  }) async {
    final response = await dio.get(
      "/api/v1/schedule-dates/details",
      queryParameters: {"subject": subject, "type": type},
    );

    final list = response.data['data'] as List;

    return list.map((e) => StudentDateModel.fromJson(e)).toList();
  }

  Future<List<Map<String, dynamic>>> fetchLessonsFilters() async {
    final response = await dio.get('/api/v1/schedule-dates/subjects-list');

    return List<Map<String, dynamic>>.from(response.data['data']['subjects']);
  }

  Future<List<LessonScheduleModel>> fetchLessonsDetails({
    required String subject,
    required String teacher,
    required int month,
    required int year,
  }) async {
    final response = await dio.get(
      '/api/v1/schedule-dates/grade-details',
      queryParameters: {
        "subject": subject,
        "teacher": teacher,
        "month": month,
        "year": year,
      },
    );

    return (response.data['data'] as List)
        .map((e) => LessonScheduleModel.fromJson(e))
        .toList();
  }
}
