class AssistantModel {
  final int code;
  final String name;
  final String phoneNumber;

  AssistantModel({
    required this.code,
    required this.name,
    required this.phoneNumber,
  });

  factory AssistantModel.fromJson(Map<String, dynamic> json) {
    return AssistantModel(
      code: json['code'],
      name: json['name'],
      phoneNumber: json['phonenumber'],
    );
  }
}