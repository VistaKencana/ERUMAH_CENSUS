import 'dart:convert';

OcrJsonResponseModel ocrJsonResponseModelFromJson(String str) =>
    OcrJsonResponseModel.fromJson(json.decode(str));

String ocrJsonResponseModelToJson(OcrJsonResponseModel data) =>
    json.encode(data.toJson());

class OcrJsonResponseModel {
  String? status;
  String? message;
  OcrDataModel? data;

  OcrJsonResponseModel({
    this.status,
    this.message,
    this.data,
  });

  OcrJsonResponseModel copyWith({
    String? status,
    String? message,
    OcrDataModel? data,
  }) =>
      OcrJsonResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory OcrJsonResponseModel.fromJson(Map<String, dynamic> json) =>
      OcrJsonResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : OcrDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class OcrDataModel {
  String? name;
  String? icNo;
  String? address;
  String? genderCode;
  String? genderDesc;

  OcrDataModel({
    this.name,
    this.icNo,
    this.address,
    this.genderCode,
    this.genderDesc,
  });

  OcrDataModel copyWith({
    String? name,
    String? icNo,
    String? address,
    String? genderCode,
    String? genderDesc,
  }) =>
      OcrDataModel(
        name: name ?? this.name,
        icNo: icNo ?? this.icNo,
        address: address ?? this.address,
        genderCode: genderCode ?? this.genderCode,
        genderDesc: genderDesc ?? this.genderDesc,
      );

  factory OcrDataModel.fromJson(Map<String, dynamic> json) => OcrDataModel(
        name: json["name"],
        icNo: json["icNo"],
        address: json["address"],
        genderCode: json["genderCode"],
        genderDesc: json["genderDesc"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "icNo": icNo,
        "address": address,
        "genderCode": genderCode,
        "genderDesc": genderDesc,
      };
}
