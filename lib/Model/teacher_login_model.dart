/// status : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2RlIjoyNTAwMCwibl9tb2QiOiLZhdit2YXYryDZhdit2YXYryDZh9in2LTZhSIsInJvbGUiOiJ0ZWFjaGVyIiwiaWF0IjoxNzcyMTM5MDYwLCJleHAiOjE3NzI3NDM4NjB9.H2hX137bxGOUxUkX8Pn97SuwMzYNJYsVVSaJSu0nX-M"
/// data : {"teacher":{"code":25000,"n_mod":"محمد محمد هاشم","n_mada":"حاسب الى","phonenumber":"0120000000","personal_id":null,"personal_image":"https://res.cloudinary.com/dabctzhqd/image/upload/v1772112170/teachers/25000/profile/weodmyvjwfq8r4xx1x9g.jpg","password":"$2b$10$fGc.am0sSJzkTrqSZd2cJeoLsZIFLi5OtR.mZUf/XibtoBfWvzv.S"}}

class TeacherLoginModel {
  TeacherLoginModel({this.status, this.token, this.data});

  TeacherLoginModel.fromJson(dynamic json) {
    status = json['status'];
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? token;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['token'] = token;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// teacher : {"code":25000,"n_mod":"محمد محمد هاشم","n_mada":"حاسب الى","phonenumber":"0120000000","personal_id":null,"personal_image":"https://res.cloudinary.com/dabctzhqd/image/upload/v1772112170/teachers/25000/profile/weodmyvjwfq8r4xx1x9g.jpg","password":"$2b$10$fGc.am0sSJzkTrqSZd2cJeoLsZIFLi5OtR.mZUf/XibtoBfWvzv.S"}

class Data {
  Data({this.teacher});

  Data.fromJson(dynamic json) {
    teacher = json['teacher'] != null
        ? Teacher.fromJson(json['teacher'])
        : null;
  }
  Teacher? teacher;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (teacher != null) {
      map['teacher'] = teacher?.toJson();
    }
    return map;
  }
}

/// code : 25000
/// n_mod : "محمد محمد هاشم"
/// n_mada : "حاسب الى"
/// phonenumber : "0120000000"
/// personal_id : null
/// personal_image : "https://res.cloudinary.com/dabctzhqd/image/upload/v1772112170/teachers/25000/profile/weodmyvjwfq8r4xx1x9g.jpg"
/// password : "$2b$10$fGc.am0sSJzkTrqSZd2cJeoLsZIFLi5OtR.mZUf/XibtoBfWvzv.S"

class Teacher {
  Teacher({
    this.code,
    this.nMod,
    this.nMada,
    this.phonenumber,
    this.personalId,
    this.personalImage,
    this.verified,
    this.password,
  });

  Teacher.fromJson(dynamic json) {
    code = json['code'];
    nMod = json['n_mod'];
    nMada = json['n_mada'];
    phonenumber = json['phonenumber'];
    personalId = json['personal_id'];
    personalImage = json['personal_image'];
    password = json['password'];
    verified = json['verified'] == 1 || json['verified'] == true;
  }
  String? code;
  String? nMod;
  String? nMada;
  String? phonenumber;
  dynamic personalId;
  String? personalImage;
  String? password;
  bool? verified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['n_mod'] = nMod;
    map['n_mada'] = nMada;
    map['phonenumber'] = phonenumber;
    map['personal_id'] = personalId;
    map['personal_image'] = personalImage;
    map['password'] = password;
    map['verified'] = verified;
    return map;
  }
}
