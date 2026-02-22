/// status : "success"
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjQ4NDY2LCJuYW1lIjoiUGFyZW50IiwiaWF0IjoxNzcxNzAxMTUyLCJleHAiOjE3NzIzMDU5NTJ9.Xiy6_5zbicpqeVTht-t_IBtYZr31rWu3Dmapzo1D5IU"
/// data : {"parent":{"id":248466,"name":"Parent","tel":"01204241568","personal_id":null,"profile_image":null}}

class ParentLoginModel {
  ParentLoginModel({this.status, this.token, this.data});

  ParentLoginModel.fromJson(dynamic json) {
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

/// parent : {"id":248466,"name":"Parent","tel":"01204241568","personal_id":null,"profile_image":null}

class Data {
  Data({this.parent});

  Data.fromJson(dynamic json) {
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
  }
  Parent? parent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (parent != null) {
      map['parent'] = parent?.toJson();
    }
    return map;
  }
}

/// id : 248466
/// name : "Parent"
/// tel : "01204241568"
/// personal_id : null
/// profile_image : null

class Parent {
  Parent({
    this.id,
    this.name,
    this.tel,
    this.password,
    this.personalId,
    this.verified,
    this.profileImage,
  });

  Parent.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    tel = json['tel'];
    password = json['password'];
    personalId = json['personal_id'];
    profileImage = json['profile_image'];
    verified = json['verified'] == 1 || json['verified'] == true;
  }
  String? id;
  String? name;
  String? tel;
  String? password;
  dynamic personalId;
  dynamic profileImage;
  bool? verified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['tel'] = tel;
    map['password'] = password;
    map['personal_id'] = personalId;
    map['profile_image'] = profileImage;
    map['verified'] = verified;
    return map;
  }
}
