import 'dart:convert';

ZoneModel zoneModelFromJson(String str) => ZoneModel.fromJson(json.decode(str));

String zoneModelToJson(ZoneModel data) => json.encode(data.toJson());

class ZoneModel {
  String? status;
  List<ZoneData>? data;

  ZoneModel({
    this.status,
    this.data,
  });

  ZoneModel copyWith({
    String? status,
    List<ZoneData>? data,
  }) =>
      ZoneModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory ZoneModel.fromJson(Map<String, dynamic> json) => ZoneModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ZoneData>.from(
                json["data"]!.map((x) => ZoneData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ZoneData {
  String? code;
  String? desc;
  String? pic;
  String? phoneNo;

  ZoneData({
    this.code,
    this.desc,
    this.pic,
    this.phoneNo,
  });

  ZoneData copyWith({
    String? code,
    String? desc,
    String? pic,
    String? phoneNo,
  }) =>
      ZoneData(
        code: code ?? this.code,
        desc: desc ?? this.desc,
        pic: pic ?? this.pic,
        phoneNo: phoneNo ?? this.phoneNo,
      );

  factory ZoneData.fromJson(Map<String, dynamic> json) => ZoneData(
        code: json["code"],
        desc: json["desc"],
        pic: json["pic"],
        phoneNo: json["phoneNo"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
        "pic": pic,
        "phoneNo": phoneNo,
      };
}
