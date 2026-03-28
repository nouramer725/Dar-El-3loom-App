/// status : "success"
/// count : 5
/// data : {"mozakrat":[{"n_mod":"string","n_mada":"string","p_sales":0,"n_sanf":"string"}]}

class MozakratModel {
  MozakratModel({
      this.status, 
      this.count, 
      this.data,});

  MozakratModel.fromJson(dynamic json) {
    status = json['status'];
    count = json['count'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  int? count;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// mozakrat : [{"n_mod":"string","n_mada":"string","p_sales":0,"n_sanf":"string"}]

class Data {
  Data({
      this.mozakrat,});

  Data.fromJson(dynamic json) {
    if (json['mozakrat'] != null) {
      mozakrat = [];
      json['mozakrat'].forEach((v) {
        mozakrat?.add(Mozakrat.fromJson(v));
      });
    }
  }
  List<Mozakrat>? mozakrat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mozakrat != null) {
      map['mozakrat'] = mozakrat?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// n_mod : "string"
/// n_mada : "string"
/// p_sales : 0
/// n_sanf : "string"

class Mozakrat {
  Mozakrat({
      this.nMod, 
      this.nMada, 
      this.pSales, 
      this.nSanf,});

  Mozakrat.fromJson(dynamic json) {
    nMod = json['n_mod'];
    nMada = json['n_mada'];
    pSales = json['p_sales'];
    nSanf = json['n_sanf'];
  }
  String? nMod;
  String? nMada;
  int? pSales;
  String? nSanf;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['n_mod'] = nMod;
    map['n_mada'] = nMada;
    map['p_sales'] = pSales;
    map['n_sanf'] = nSanf;
    return map;
  }

}