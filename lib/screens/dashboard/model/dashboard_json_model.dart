import 'dart:convert';

DashboardJsonModel latestJsonModelFromJson(String str) =>
    DashboardJsonModel.fromJson(json.decode(str));

String latestJsonModelToJson(DashboardJsonModel data) =>
    json.encode(data.toJson());

class DashboardJsonModel {
  String? status;
  String? message;
  List<DashboardModel>? data;

  DashboardJsonModel({
    this.status,
    this.message,
    this.data,
  });

  DashboardJsonModel copyWith({
    String? status,
    String? message,
    List<DashboardModel>? data,
  }) =>
      DashboardJsonModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DashboardJsonModel.fromJson(Map<String, dynamic> json) =>
      DashboardJsonModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<DashboardModel>.from(
                json["data"]!.map((x) => DashboardModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DashboardModel {
  String? censusCode;
  HousingProject? status;
  HousingProject? housingProject;
  Unit? unit;
  List<Visit>? visit;

  DashboardModel({
    this.censusCode,
    this.status,
    this.housingProject,
    this.unit,
    this.visit,
  });

  DashboardModel copyWith({
    String? censusCode,
    HousingProject? status,
    HousingProject? housingProject,
    Unit? unit,
    List<Visit>? visit,
  }) =>
      DashboardModel(
        censusCode: censusCode ?? this.censusCode,
        status: status ?? this.status,
        housingProject: housingProject ?? this.housingProject,
        unit: unit ?? this.unit,
        visit: visit ?? this.visit,
      );

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        censusCode: json["censusCode"],
        status: json["status"] == null
            ? null
            : HousingProject.fromJson(json["status"]),
        housingProject: json["housingProject"] == null
            ? null
            : HousingProject.fromJson(json["housingProject"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
        visit: json["visit"] == null
            ? []
            : List<Visit>.from(json["visit"]!.map((x) => Visit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "censusCode": censusCode,
        "status": status?.toJson(),
        "housingProject": housingProject?.toJson(),
        "unit": unit?.toJson(),
        "visit": visit == null
            ? []
            : List<dynamic>.from(visit!.map((x) => x.toJson())),
      };
}

class HousingProject {
  String? code;
  String? desc;

  HousingProject({
    this.code,
    this.desc,
  });

  HousingProject copyWith({
    String? code,
    String? desc,
  }) =>
      HousingProject(
        code: code ?? this.code,
        desc: desc ?? this.desc,
      );

  factory HousingProject.fromJson(Map<String, dynamic> json) => HousingProject(
        code: json["code"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
      };
}

class Unit {
  String? code;
  String? unitNo;
  String? qrCode;

  Unit({
    this.code,
    this.unitNo,
    this.qrCode,
  });

  Unit copyWith({
    String? code,
    String? unitNo,
    String? qrCode,
  }) =>
      Unit(
        code: code ?? this.code,
        unitNo: unitNo ?? this.unitNo,
        qrCode: qrCode ?? this.qrCode,
      );

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        code: json["code"],
        unitNo: json["unitNo"],
        qrCode: json["qrCode"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "unitNo": unitNo,
        "qrCode": qrCode,
      };
}

class Visit {
  String? round;
  String? date;
  HousingProject? status;
  String? remark;

  Visit({
    this.round,
    this.date,
    this.status,
    this.remark,
  });

  Visit copyWith({
    String? round,
    String? date,
    HousingProject? status,
    String? remark,
  }) =>
      Visit(
        round: round ?? this.round,
        date: date ?? this.date,
        status: status ?? this.status,
        remark: remark ?? this.remark,
      );

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
        round: json["round"],
        date: json["date"],
        status: json["status"] == null
            ? null
            : HousingProject.fromJson(json["status"]),
        remark: json["remark"],
      );

  Map<String, dynamic> toJson() => {
        "round": round,
        "date": date,
        "status": status?.toJson(),
        "remark": remark,
      };
}
