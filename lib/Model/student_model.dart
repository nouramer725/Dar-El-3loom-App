class StudentModel {
  final String code;
  final String name;
  final String level;
  final String phoneStudent;
  final String phoneParent;
  final String nationalId;
  final String password;
  final String? birthImage;
  final String? studentImage;

  StudentModel({
    required this.code,
    required this.name,
    required this.level,
    required this.phoneStudent,
    required this.phoneParent,
    required this.nationalId,
    required this.password,
    this.birthImage,
    this.studentImage,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    String clean(String? value) {
      if (value == null || value.toLowerCase() == "string") return "";
      return value;
    }

    return StudentModel(
      code: clean(json["cod_talb"]),
      name: clean(json["n_talb"]),
      level: clean(json["n_saf"]),
      phoneStudent: clean(json["tel"]),
      phoneParent: clean(json["tel_1"]),
      nationalId: clean(json["personal_id"]),
      password: clean(json["password"]),
      birthImage: json["birth_certificate"],
      studentImage: json["profile_picture"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "cod_talb": code,
      "n_talb": name,
      "n_saf": level,
      "tel": phoneStudent,
      "tel_1": phoneParent,
      "personal_id": nationalId,
      "password": password,
      "birth_certificate": birthImage,
      "profile_picture": studentImage,
    };
  }
}
