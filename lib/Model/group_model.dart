import 'package:intl/intl.dart';

class GroupModel {
  final String groupNo;
  final String className;
  final String date;
  final String time;
  final String day;
  final int totalStudents;
  final List<StudentModel> students;

  GroupModel({
    required this.groupNo,
    required this.className,
    required this.date,
    required this.time,
    required this.day,
    required this.totalStudents,
    required this.students,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    final studentsJson = json['students'] as List<dynamic>? ?? [];

    // Parse time string to DateTime and format
    String formattedTime = '';
    try {
      final rawTime = json['time_h1'] ?? '';
      if (rawTime.isNotEmpty) {
        final dt = DateFormat("HH:mm:ss").parse(rawTime); // parse 24h format
        formattedTime = DateFormat.jm().format(dt); // converts to 12h format like 2:00 PM
      }
    } catch (e) {
      formattedTime = json['time_h1'] ?? '';
    }

    return GroupModel(
      groupNo: json['no_group'] ?? '',
      className: json['n_saf'] ?? '',
      date: json['date_h1'] ?? '',
      time: formattedTime,
      day: json['day_h1'] ?? '',
      totalStudents: json['totalStudents'] ?? 0,
      students: studentsJson.map((s) => StudentModel.fromJson(s)).toList(),
    );
  }
}

/// Student model
class StudentModel {
  final String code;
  final String name;

  StudentModel({required this.code, required this.name});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      code: (json['cod'] ?? '').toString(),
      name: json['name'] ?? '',
    );
  }
}
