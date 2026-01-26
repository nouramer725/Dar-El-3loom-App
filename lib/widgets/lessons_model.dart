class Lesson {
  final String name;
  final String date;
  final String time;
  final String score;
  final bool passed;

  Lesson({
    required this.name,
    required this.date,
    required this.time,
    required this.score,
    required this.passed,
  });
}
List<Lesson> lessons = [
  Lesson(name: "الأولى", date: "22/10/2025", time: "03:00", score: "20/20", passed: true),
  Lesson(name: "الثانية", date: "22/10/2025", time: "03:00", score: "20/20", passed: true),
  Lesson(name: "الثالثة", date: "22/10/2025", time: "03:00", score: "20/20", passed: false),
  Lesson(name: "الرابعة", date: "22/10/2025", time: "03:00", score: "20/20", passed: true),
];
