import 'dart:io';
import 'package:dar_el_3loom/Model/assistant_login_model.dart';
import 'package:dar_el_3loom/Model/mozakrat_model.dart';
import 'package:dar_el_3loom/Model/parent_login_model.dart';
import 'package:dar_el_3loom/Model/student_login_model.dart';
import 'package:dar_el_3loom/Model/teacher_login_model.dart';
import 'package:dio/dio.dart';
import '../../Model/balance_model.dart';
import '../../Model/group_model.dart';
import '../../Model/lessons_date_model.dart';
import '../../Model/student_time_model.dart';
import '../../Model/takim_model.dart';
import '../../home_teacher/tabs/profile/profile_tabs/get_assistant/assistant_model.dart';

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
      data: {"cod_talb": code.trim(), "tel": parentNumber.trim()},
      options: Options(validateStatus: (status) => true),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> verifyParent({
    required int id,
    required String parentNumber,
  }) async {
    final response = await dio.post(
      '/api/v1/parents/verify',
      data: {"id": id, "tel": parentNumber.trim()},
      options: Options(validateStatus: (status) => true),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> verifyTeacher({
    required String id,
    required String parentNumber,
  }) async {
    final response = await dio.post(
      '/api/v1/teachers/verify',
      data: {"code": id, "phonenumber": parentNumber.trim()},
      options: Options(validateStatus: (status) => true),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> verifyAssistant({
    required String id,
    required String parentNumber,
  }) async {
    final response = await dio.post(
      '/api/v1/assistants/verify',
      data: {"code": id, "phonenumber": parentNumber.trim()},
      options: Options(validateStatus: (status) => true),
    );

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
      "parent_id": student.parentId,
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

  Future<Map<String, dynamic>> updateParentInfo(Parent parent) async {
    FormData formData = FormData.fromMap({
      "id": parent.id,
      "name": parent.name,
      "tel": parent.tel,
      "personal_id": parent.personalId,
      "password": parent.password,
      "verified": parent.verified,
    });

    if (parent.profileImage != null && parent.profileImage!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "profile_image",
          await MultipartFile.fromFile(parent.profileImage!),
        ),
      );
    }

    final response = await dio.patch(
      '/api/v1/parents/${parent.id}',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> updateTeacherInfo(Teacher teacher) async {
    FormData formData = FormData.fromMap({
      "code": teacher.code,
      "n_mod": teacher.nMod,
      "n_mada": teacher.nMada,
      "phonenumber": teacher.phonenumber,
      "personal_id": teacher.personalId,
      "password": teacher.password,
      "verified": teacher.verified,
    });

    if (teacher.personalImage != null && teacher.personalImage!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "personal_image",
          await MultipartFile.fromFile(teacher.personalImage!),
        ),
      );
    }

    final response = await dio.patch(
      '/api/v1/teachers/${teacher.code}',
      data: formData,
      options: Options(headers: {"Content-Type": "multipart/form-data"}),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> updateAssistantInfo(Assistant assistant) async {
    FormData formData = FormData.fromMap({
      "code": assistant.code,
      "teacher_name": assistant.nMod,
      "name": assistant.name,
      "n_mada": assistant.nMada,
      "phonenumber": assistant.phonenumber,
      "personal_id": assistant.personalId,
      "password": assistant.password,
      "verified": assistant.verified,
    });

    if (assistant.birthdayCertificate != null &&
        assistant.birthdayCertificate!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "birthday_certificate",
          await MultipartFile.fromFile(assistant.birthdayCertificate!),
        ),
      );
    }

    if (assistant.personalImage != null &&
        assistant.personalImage!.isNotEmpty) {
      formData.files.add(
        MapEntry(
          "personal_image",
          await MultipartFile.fromFile(assistant.personalImage!),
        ),
      );
    }

    final response = await dio.patch(
      '/api/v1/teachers/${assistant.code}',
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
      options: Options(validateStatus: (status) => true),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> loginTeacher({
    required String code,
    required String password,
  }) async {
    final response = await dio.post(
      '/api/v1/teachers/login',
      data: {"code": code, "password": password},
      options: Options(validateStatus: (status) => true),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> loginAssistant({
    required String code,
    required String password,
  }) async {
    final response = await dio.post(
      '/api/v1/assistants/login',
      data: {"code": code, "password": password},
      options: Options(validateStatus: (status) => true),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> loginParent({
    required String id,
    required String password,
  }) async {
    final response = await dio.post(
      '/api/v1/parents/login',
      data: {"id": id, "password": password},
      options: Options(validateStatus: (status) => true),
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

  Future<Map<String, dynamic>> changePasswordParent({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        '/api/v1/parents/change-password',
        data: {"oldPassword": oldPassword, "newPassword": newPassword},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => true,
        ),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print("Change password error data: ${e.response!.data}");
        return e.response!.data;
      } else {
        return {'status': 'fail', 'message': e.message};
      }
    } catch (e) {
      return {'status': 'fail', 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> changePasswordTeacher({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        '/api/v1/teachers/change-password',
        data: {"oldPassword": oldPassword, "newPassword": newPassword},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => true,
        ),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print("Change password error data: ${e.response!.data}");
        return e.response!.data;
      } else {
        return {'status': 'fail', 'message': e.message};
      }
    } catch (e) {
      return {'status': 'fail', 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> changePasswordAssistant({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final response = await dio.post(
        '/api/v1/assistants/change-password',
        data: {"oldPassword": oldPassword, "newPassword": newPassword},
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => true,
        ),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        print("Change password error data: ${e.response!.data}");
        return e.response!.data;
      } else {
        return {'status': 'fail', 'message': e.message};
      }
    } catch (e) {
      return {'status': 'fail', 'message': e.toString()};
    }
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

  Future<Map<String, dynamic>> uploadProfilePictureParent(
    File imageFile,
  ) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        'profile_image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        '/api/v1/parents/profile-image',
        data: formData,
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      } else {
        return {'status': 'fail', 'message': e.message};
      }
    } catch (e) {
      return {'status': 'fail', 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> uploadProfilePictureAssistant(
    File imageFile,
  ) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        'profile_image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        '/api/v1/assistants/profile-image',
        data: formData,
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      } else {
        return {'status': 'fail', 'message': e.message};
      }
    } catch (e) {
      return {'status': 'fail', 'message': e.toString()};
    }
  }

  Future<Map<String, dynamic>> uploadProfilePictureTeacher(
    File imageFile,
  ) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        'personal_image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        '/api/v1/teachers/profile-image',
        data: formData,
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      } else {
        return {'status': 'fail', 'message': e.message};
      }
    } catch (e) {
      return {'status': 'fail', 'message': e.toString()};
    }
  }

  Future<List<Mozakrat>> fetchMozakrat({
    String filter = 'all',
    String? childId,
  }) async {
    try {
      final response = await dio.get(
        '/api/v1/mozakrat',
        options: Options(headers: {'filter': filter}),
        queryParameters: {if (childId != null) "child_id": childId},
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'] ?? {};
        final mozakratList = data['mozakrat'] ?? [];
        if (mozakratList is List) {
          return mozakratList.map((e) => Mozakrat.fromJson(e)).toList();
        }
      }

      return [];
    } catch (e) {
      print("Error fetching mozakrat: $e");
      return [];
    }
  }

  // Fetch subjects and teachers for the student
  Future<List<Map<String, dynamic>>> fetchSubjects({String? childId}) async {
    try {
      final response = await dio.get(
        '/api/v1/schedule/subjects',
        queryParameters: {if (childId != null) "child_id": childId},
      );
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
    String? childId,
  }) async {
    try {
      final response = await dio.get(
        '/api/v1/schedule/details',
        queryParameters: {
          'subject': subject,
          'teacher': teacher,
          'month': month,
          'year': year ?? DateTime.now().year,
          if (childId != null) "child_id": childId,
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

  Future<List<Map<String, dynamic>>> fetchBalanceFilters({
    String? childId,
  }) async {
    final response = await dio.get(
      "/api/v1/madfoaat/teachers",
      queryParameters: {if (childId != null) "child_id": childId},
    );

    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<List<BalanceModel>> fetchBalanceDetails({
    String? subject,
    String? teacher,
    String? status,
    String? childId,
  }) async {
    final response = await dio.get(
      "/api/v1/madfoaat",
      queryParameters: {
        if (subject != null) "subject": subject,
        if (teacher != null) "teacher": teacher,
        if (status != null) "status": status,
        if (childId != null) "child_id": childId,
      },
    );

    final data = response.data['data'] as List;

    return data.map((e) => BalanceModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>?> fetchTakiim({
    required int month,
    String? childId,
  }) async {
    try {
      final response = await dio.get(
        "/api/v1/takrer",
        queryParameters: {
          "month": month,
          if (childId != null) "child_id": childId,
        },
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

  Future<List<String>> fetchScheduleSubjects({String? childId}) async {
    final response = await dio.get(
      "/api/v1/schedule-dates",
      queryParameters: {if (childId != null) "child_id": childId},
    );

    final data = response.data['data'] as List;

    return data.map<String>((e) => e['n_mada'].toString()).toSet().toList();
  }

  Future<List<StudentDateModel>> fetchScheduleDatesDetails({
    required String subject,
    required String type,
    String? childId,
  }) async {
    final response = await dio.get(
      "/api/v1/schedule-dates/details",
      queryParameters: {
        "subject": subject,
        "type": type,
        if (childId != null) "child_id": childId,
      },
    );

    final list = response.data['data'] as List;

    return list.map((e) => StudentDateModel.fromJson(e)).toList();
  }

  Future<List<Map<String, dynamic>>> fetchLessonsFilters({
    String? childId,
  }) async {
    final response = await dio.get(
      '/api/v1/schedule-dates/subjects-list',
      queryParameters: {if (childId != null) "child_id": childId},
    );

    return List<Map<String, dynamic>>.from(response.data['data']['subjects']);
  }

  Future<List<LessonScheduleModel>> fetchLessonsDetails({
    required String subject,
    required String teacher,
    required int month,
    required int year,
    String? childId,
  }) async {
    final response = await dio.get(
      '/api/v1/schedule-dates/grade-details',
      queryParameters: {
        "subject": subject,
        "teacher": teacher,
        "month": month,
        "year": year,
        if (childId != null) "child_id": childId,
      },
    );

    return (response.data['data'] as List)
        .map((e) => LessonScheduleModel.fromJson(e))
        .toList();
  }

  Future<List<Student>> getChildren() async {
    try {
      final response = await dio.get(
        "/api/v1/parents/children",
        options: Options(validateStatus: (status) => true),
      );

      if (response.data['status'] == 'success') {
        List childrenJson = response.data['data']['children'] ?? [];
        return childrenJson.map((e) => Student.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching children: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> addAssistant({
    required String name,
    required String phone,
  }) async {
    try {
      final response = await dio.post(
        '/api/v1/teachers/assistant',
        data: {"name": name.trim(), "phonenumber": phone.trim()},
        options: Options(validateStatus: (status) => true),
      );

      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!.data;
      }
      return {"status": "fail", "message": e.message};
    }
  }

  Future<List<AssistantModel>> getAssistants() async {
    print("🪪 AUTH HEADER = ${dio.options.headers['Authorization']}");

    final response = await dio.get("/api/v1/teachers/assistant");

    print("✅ RESPONSE = ${response.data}");

    final List assistantsJson = response.data['data']['assistants'];

    return assistantsJson.map((e) => AssistantModel.fromJson(e)).toList();
  }

  Future<List<String>> fetchTeacherGroups() async {
    try {
      final response = await dio.get("/api/v1/teachers/groups");
      if (response.data['status'] == 'success') {
        final groups = response.data['data']['groups'] as List<dynamic>;
        return groups.map((e) => e.toString()).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching teacher groups: $e");
      return [];
    }
  }

  Future<GroupModel?> fetchGroupDetailsAsGroup({
    required String groupNo,
    int page = 1,
    int limit = 100,
  }) async {
    try {
      final response = await dio.get(
        "/api/v1/teachers/groups/$groupNo",
        queryParameters: {"page": page, "limit": limit},
      );

      if (response.data['status'] == 'success') {
        final data = response.data['data'];

        final studentsList = (data['students'] as List<dynamic>)
            .map((e) => StudentModel.fromJson(e))
            .toList();

        final group = GroupModel(
          groupNo: data['no_group'] ?? groupNo,
          students: studentsList,
          className: data['n_saf'] ?? '',
          date: data['date_h1'] ?? '',
          time: data['time_h1'] ?? '',
          day: data['day_h1'] ?? '',
          totalStudents: data['totalStudents'] ?? 0,
        );

        return group;
      } else {
        return null;
      }
    } catch (e) {
      print("Error fetching group details: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> fetchTeacherTakiim(String studentCode) async {
    try {
      final response = await dio.get(
        '/api/v1/teachers/takrer',
        queryParameters: {'cod_talb': studentCode},
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception fetching Takiim: $e');
      return null;
    }
  }
}
