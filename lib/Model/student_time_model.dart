class StudentDateModel {
  final String groupNumber;
  final String teacher;
  final String subject;
  final String date;
  final String time;

  StudentDateModel({
    required this.groupNumber,
    required this.teacher,
    required this.subject,
    required this.date,
    required this.time,
  });

  factory StudentDateModel.fromJson(Map<String, dynamic> json) {
    return StudentDateModel(
      groupNumber: json['no_group']?.toString() ?? "-",
      teacher: json['n_mod']?.toString() ?? "-",
      subject: json['n_mada']?.toString() ?? "-",
      date: json['date']?.toString() ?? "-",
      time: json['time']?.toString() ?? "-",
    );
  }
}
