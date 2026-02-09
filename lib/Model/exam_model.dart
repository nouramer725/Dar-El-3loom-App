class ExamModel {
  final String examDate;
  final int studentScore;
  final int maxScore;
  final int percentage;
  final String gradeDisplay;

  ExamModel({
    required this.examDate,
    required this.studentScore,
    required this.maxScore,
    required this.percentage,
    required this.gradeDisplay,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      examDate: json['exam_date'],
      studentScore: json['student_score'],
      maxScore: json['max_score'],
      percentage: json['percentage'],
      gradeDisplay: json['grade_display'],
    );
  }
}
