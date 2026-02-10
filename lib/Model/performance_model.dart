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
    return SessionModel(
      sessionNumber: json['session_number'],
      date: json['date'],
      attendanceStatus: json['attendance']['status'],
      attendanceIcon: json['attendance']['icon'],
      homework: json['homework'],
      evaluation: json['evaluation'],
    );
  }
}
