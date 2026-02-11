class TakiimModel {
  final String date;
  final String groupNumber;
  final String teacher;
  final String subject;
  final int studentGrade;
  final int maxGrade;
  final int percentage;

  TakiimModel({
    required this.date,
    required this.groupNumber,
    required this.teacher,
    required this.subject,
    required this.studentGrade,
    required this.maxGrade,
    required this.percentage,
  });

  factory TakiimModel.fromJson(Map<String, dynamic> json) {
    return TakiimModel(
      date: json['dates']?.toString() ?? '',
      groupNumber: json['no_group']?.toString() ?? '',
      teacher: json['n_mod']?.toString() ?? '',
      subject: json['n_mada']?.toString() ?? '',
      studentGrade: json['gadestudent'] is int
          ? json['gadestudent']
          : int.tryParse(json['gadestudent'].toString()) ?? 0,
      maxGrade: json['maximumgrade'] is int
          ? json['maximumgrade']
          : int.tryParse(json['maximumgrade'].toString()) ?? 0,
      percentage: json['perstangestudent'] is int
          ? json['perstangestudent']
          : int.tryParse(json['perstangestudent'].toString()) ?? 0,
    );
  }
}
