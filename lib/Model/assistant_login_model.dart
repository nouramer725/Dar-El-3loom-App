/// status : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb2RlIjoyNTAwMCwibl9tb2QiOiLZhdit2YXYryDZhdit2YXYryDZh9in2LTZhSIsInJvbGUiOiJ0ZWFjaGVyIiwiaWF0IjoxNzcyMTM5MDYwLCJleHAiOjE3NzI3NDM4NjB9.H2hX137bxGOUxUkX8Pn97SuwMzYNJYsVVSaJSu0nX-M"
/// data : {"teacher":{"code":25000,"n_mod":"محمد محمد هاشم","n_mada":"حاسب الى","phonenumber":"0120000000","personal_id":null,"personal_image":"https://res.cloudinary.com/dabctzhqd/image/upload/v1772112170/teachers/25000/profile/weodmyvjwfq8r4xx1x9g.jpg","password":"$2b$10$fGc.am0sSJzkTrqSZd2cJeoLsZIFLi5OtR.mZUf/XibtoBfWvzv.S"}}

class AssistantLoginModel {
  AssistantLoginModel({this.status, this.token, this.data});

  AssistantLoginModel.fromJson(dynamic json) {
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
  Data({this.assistant});

  Data.fromJson(dynamic json) {
    assistant = json['assistant'] != null
        ? Assistant.fromJson(json['assistant'])
        : null;
  }
  Assistant? assistant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (assistant != null) {
      map['assistant'] = assistant?.toJson();
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

class Assistant {
  Assistant({
    this.code,
    this.name,
    this.nMod,
    this.nMada,
    this.phonenumber,
    this.personalId,
    this.personalImage,
    this.birthdayCertificate,
    this.verified,
    this.password,
  });

  Assistant.fromJson(dynamic json) {
    code = json['code'];
    name = json['name'];
    nMod = json['teacher_name'];
    nMada = json['n_mada'];
    phonenumber = json['phonenumber'];
    personalId = json['personal_id'];
    personalImage = json['personal_image'];
    birthdayCertificate = json['birthday_certificate'];
    password = json['password'];
    verified = json['verified'] == 1 || json['verified'] == true;
  }
  String? code;
  String? nMod;
  String? name;
  String? nMada;
  String? phonenumber;
  dynamic personalId;
  String? personalImage;
  String? password;
  bool? verified;
  String? birthdayCertificate;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['teacher_name'] = nMod;
    map['name'] = name;
    map['n_mada'] = nMada;
    map['phonenumber'] = phonenumber;
    map['personal_id'] = personalId;
    map['personal_image'] = personalImage;
    map['birthday_certificate'] = birthdayCertificate;
    map['password'] = password;
    map['verified'] = verified;
    return map;
  }
}
