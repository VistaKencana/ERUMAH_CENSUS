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
  String? zoneCode;
  String? zoneDesc;
  String? zonePic;
  String? zonePhoneNo;

  ZoneData({
    this.zoneCode,
    this.zoneDesc,
    this.zonePic,
    this.zonePhoneNo,
  });

  ZoneData copyWith({
    String? zoneCode,
    String? zoneDesc,
    String? zonePic,
    String? zonePhoneNo,
  }) =>
      ZoneData(
        zoneCode: zoneCode ?? this.zoneCode,
        zoneDesc: zoneDesc ?? this.zoneDesc,
        zonePic: zonePic ?? this.zonePic,
        zonePhoneNo: zonePhoneNo ?? this.zonePhoneNo,
      );

  factory ZoneData.fromJson(Map<String, dynamic> json) => ZoneData(
        zoneCode: json["zoneCode"],
        zoneDesc: json["zoneDesc"],
        zonePic: json["zonePic"],
        zonePhoneNo: json["zonePhoneNo"],
      );

  Map<String, dynamic> toJson() => {
        "zoneCode": zoneCode,
        "zoneDesc": zoneDesc,
        "zonePic": zonePic,
        "zonePhoneNo": zonePhoneNo,
      };
}
