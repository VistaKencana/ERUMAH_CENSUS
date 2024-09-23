import 'dart:convert';

DropdownModel dropdownModelFromJson(String str) =>
    DropdownModel.fromJson(json.decode(str));

String dropdownModelToJson(DropdownModel data) => json.encode(data.toJson());

class DropdownModel {
  String? status;
  String? message;
  Data? data;

  DropdownModel({
    this.status,
    this.message,
    this.data,
  });

  DropdownModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      DropdownModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DropdownModel.fromJson(Map<String, dynamic> json) => DropdownModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Map<String, List<DropdownData>>? dynamicData;

  Data({
    this.dynamicData,
  });

  Data copyWith({
    Map<String, List<DropdownData>>? dynamicData,
  }) =>
      Data(
        dynamicData: dynamicData ?? this.dynamicData,
      );

  factory Data.fromJson(Map<String, dynamic> json) {
    // Parsing the dynamic keys with list of DropdownData
    Map<String, List<DropdownData>> dynamicData = {};
    json.forEach((key, value) {
      dynamicData[key] = value == null
          ? []
          : List<DropdownData>.from(value.map((x) => DropdownData.fromJson(x)));
    });

    return Data(
      dynamicData: dynamicData,
    );
  }

  Map<String, dynamic> toJson() => dynamicData != null
      ? dynamicData!.map((key, value) => MapEntry(
            key,
            List<dynamic>.from(value.map((x) => x.toJson())),
          ))
      : {};
}

class DropdownData {
  String? code;
  String? desc;

  DropdownData({
    this.code,
    this.desc,
  });

  DropdownData copyWith({
    String? code,
    String? desc,
  }) =>
      DropdownData(
        code: code ?? this.code,
        desc: desc ?? this.desc,
      );

  factory DropdownData.fromJson(Map<String, dynamic> json) => DropdownData(
        code: json["code"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
      };
}
