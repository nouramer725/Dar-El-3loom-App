class StudentModel {
  final String? name;
  final String? level;
  final String? phoneStudent;
  final String? phoneParent;
  final String? nationalId;
  final String? password;
  final String? confirmPassword;
  final String? birthImage;
  final String? studentImage;

  StudentModel({
    this.name,
    this.level,
    this.phoneStudent,
    this.phoneParent,
    this.nationalId,
    this.password,
    this.confirmPassword,
    this.birthImage,
    this.studentImage,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json["name"],
      level: json["level"],
      phoneStudent: json["phoneStudent"],
      phoneParent: json["phoneParent"],
      nationalId: json["nationalId"],
      password: json["password"],
      confirmPassword: json["confirmPassword"],
      birthImage: json["birthImage"],
      studentImage: json["studentImage"],
    );
  }
}
