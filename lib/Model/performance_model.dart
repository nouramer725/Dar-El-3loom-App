class SessionModel {
  final int sessionNumber;
  final String date;
  final String attendanceStatus;
  final String attendanceIcon;
  final int homework;
  final String evaluation;

  SessionModel({
    required this.sessionNumber,
    required this.date,
    required this.attendanceStatus,
    required this.attendanceIcon,
    required this.homework,
    required this.evaluation,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    final attendance = json['attendance'];

    return SessionModel(
      sessionNumber: json['session_number'] ?? 0,
      date: json['date'] ?? '',

      attendanceStatus: attendance?['status'] ?? '',
      attendanceIcon: attendance?['icon'] ?? '',

      homework: json['homework'] ?? 0,
      evaluation: json['timeattendance']?.toString() ?? '',
    );
  }
}
