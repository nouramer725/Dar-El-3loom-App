/// status : "string"
/// token : "string"
/// data : {"student":{"cod_talb":"string","n_talb":"string","n_saf":"string","tel":"string","tel_1":"string","personal_id":"string","birth_certificate":"string","profile_picture":"string","verified":0}}

class StudentLoginModel {
  StudentLoginModel({this.status, this.token, this.data});

  StudentLoginModel.fromJson(dynamic json) {
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

/// student : {"cod_talb":"string","n_talb":"string","n_saf":"string","tel":"string","tel_1":"string","personal_id":"string","birth_certificate":"string","profile_picture":"string","verified":0}

class Data {
  Data({this.student});

  Data.fromJson(dynamic json) {
    student = json['student'] != null
        ? Student.fromJson(json['student'])
        : null;
  }
  Student? student;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (student != null) {
      map['student'] = student?.toJson();
    }
    return map;
  }
}

/// cod_talb : "string"
/// n_talb : "string"
/// n_saf : "string"
/// tel : "string"
/// tel_1 : "string"
/// personal_id : "string"
/// birth_certificate : "string"
/// profile_picture : "string"
/// verified : 0

class Student {
  Student({
    this.codTalb,
    this.password,
    this.nTalb,
    this.nSaf,
    this.tel,
    this.tel1,
    this.personalId,
    this.birthCertificate,
    this.profilePicture,
    this.verified,
  });

  Student.fromJson(dynamic json) {
    codTalb = json['cod_talb'];
    nTalb = json['n_talb'];
    password = json['password'];
    nSaf = json['n_saf'];
    tel = json['tel'];
    tel1 = json['tel_1'];
    personalId = json['personal_id'];
    birthCertificate = json['birth_certificate'];
    profilePicture = json['profile_picture'];

    verified = json['verified'] == 1 || json['verified'] == true;
  }

  String? codTalb;
  String? nTalb;
  String? password;
  String? nSaf;
  String? tel;
  String? tel1;
  String? personalId;
  String? birthCertificate;
  String? profilePicture;
  bool? verified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cod_talb'] = codTalb;
    map['n_talb'] = nTalb;
    map['password'] = password;
    map['n_saf'] = nSaf;
    map['tel'] = tel;
    map['tel_1'] = tel1;
    map['personal_id'] = personalId;
    map['birth_certificate'] = birthCertificate;
    map['profile_picture'] = profilePicture;
    map['verified'] = verified;
    return map;
  }
}
