class LessonScheduleModel {
  final String group;
  final String teacher;
  final String subject;
  final String date;
  final String time;

  LessonScheduleModel({
    required this.group,
    required this.teacher,
    required this.subject,
    required this.date,
    required this.time,
  });

  factory LessonScheduleModel.fromJson(Map<String, dynamic> json) {
    return LessonScheduleModel(
      group: json['no_group'].toString(),
      teacher: json['n_mod'] ?? "-",
      subject: json['n_mada'] ?? "-",
      date: json['date'] ?? "-",
      time: json['time'] ?? "-",
    );
  }
}
