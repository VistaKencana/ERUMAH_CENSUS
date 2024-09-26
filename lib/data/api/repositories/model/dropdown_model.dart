import 'dart:convert';

DropdownModel dropdownModelFromJson(String str) =>
    DropdownModel.fromJson(json.decode(str));

String dropdownModelToJson(DropdownModel data) => json.encode(data.toJson());

class DropdownModel {
  String? status;
  String? message;
  List<DropdownData>? data;

  DropdownModel({
    this.status,
    this.message,
    this.data,
  });

  DropdownModel copyWith({
    String? status,
    String? message,
    List<DropdownData>? data,
  }) =>
      DropdownModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DropdownModel.fromJson(Map<String, dynamic> json) => DropdownModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DropdownData>.from(
                json["data"]!.map((x) => DropdownData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
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
