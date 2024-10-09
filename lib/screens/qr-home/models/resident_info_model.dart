// To parse this JSON data, do
//
//     final residentInfoModel = residentInfoModelFromJson(jsonString);

import 'dart:convert';

ResidentInfoModel residentInfoModelFromJson(String str) =>
    ResidentInfoModel.fromJson(json.decode(str));

String residentInfoModelToJson(ResidentInfoModel data) =>
    json.encode(data.toJson());

class ResidentInfoModel {
  String? status;
  String? message;
  ResidentInfoData? data;

  ResidentInfoModel({
    this.status,
    this.message,
    this.data,
  });

  ResidentInfoModel copyWith({
    String? status,
    String? message,
    ResidentInfoData? data,
  }) =>
      ResidentInfoModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ResidentInfoModel.fromJson(Map<String, dynamic> json) =>
      ResidentInfoModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : ResidentInfoData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class ResidentInfoData {
  String? qrCode;
  String? censusCode;
  String? censusStatus;
  String? censusStatusCode;
  UnitData? unit;
  OwnerData? owner;
  List<SpouseData>? spouse;
  DependantsModel? dependants;
  List<VisitData>? visits;

  ResidentInfoData({
    this.qrCode,
    this.censusCode,
    this.censusStatus,
    this.censusStatusCode,
    this.unit,
    this.owner,
    this.spouse,
    this.dependants,
    this.visits,
  });

  ResidentInfoData copyWith({
    String? qrCode,
    String? censusCode,
    String? censusStatus,
    String? censusStatusCode,
    UnitData? unit,
    OwnerData? owner,
    List<SpouseData>? spouse,
    DependantsModel? dependants,
    List<VisitData>? visits,
  }) =>
      ResidentInfoData(
        qrCode: qrCode ?? this.qrCode,
        censusCode: censusCode ?? this.censusCode,
        censusStatus: censusStatus ?? this.censusStatus,
        censusStatusCode: censusStatusCode ?? this.censusStatusCode,
        unit: unit ?? this.unit,
        owner: owner ?? this.owner,
        spouse: spouse ?? this.spouse,
        dependants: dependants ?? this.dependants,
        visits: visits ?? this.visits,
      );

  factory ResidentInfoData.fromJson(Map<String, dynamic> json) =>
      ResidentInfoData(
        qrCode: json["qrCode"],
        censusCode: json["censusCode"],
        censusStatus: json["censusStatus"],
        censusStatusCode: json["censusStatusCode"],
        unit: json["unit"] == null ? null : UnitData.fromJson(json["unit"]),
        owner: json["owner"] == null ? null : OwnerData.fromJson(json["owner"]),
        spouse: json["spouse"] == null ||
                (json["spouse"] is List && json["spouse"].isEmpty)
            ? []
            : List<SpouseData>.from(
                json["spouse"]!.map((x) => SpouseData.fromJson(x))),
        dependants: json["dependants"] == null
            ? null
            : DependantsModel.fromJson(json["dependants"]),
        visits: json["visits"] == null ||
                (json["visits"] is List && json["visits"].isEmpty)
            ? []
            : List<VisitData>.from(
                json["visits"]!.map((x) => VisitData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "qrCode": qrCode,
        "censusCode": censusCode,
        "censusStatus": censusStatus,
        "censusStatusCode": censusStatusCode,
        "unit": unit?.toJson(),
        "owner": owner?.toJson(),
        "spouse": (spouse == null || (spouse?.isEmpty ?? true))
            ? []
            : List<dynamic>.from(spouse!.map((x) => x.toJson())),
        "dependants": dependants?.toJson(),
        "visits": (visits == null || (visits?.isEmpty ?? true))
            ? []
            : List<dynamic>.from(visits!.map((x) => x.toJson())),
      };

  Map<String, dynamic> toOwnerJson() {
    return {
      'censusCode': censusCode, //Get from resident data
      'isNotOwner': "0", //0-false 1- true
      'name': owner?.name ?? "",
      'icNo': owner?.icNo ?? "",
      'totalHousehold': owner?.totalHousehold ?? "",
      'email': owner?.email ?? "",
      'phoneNo': owner?.phoneNo ?? "",
      "age": owner?.age ?? "",
      'isOku': (owner?.isOku == null || (owner?.isOku?.isEmpty ?? true))
          ? "0"
          : owner?.isOku ?? "",
      'workAddress': owner?.occupation?.workplace?.address ?? "",
      'workSalary': owner?.income?.basicSalary ?? "",
      'workAllowance': owner?.income?.allowance ?? "",
      'workOtherIncome': owner?.income?.other ?? "",
      'welfareAid': owner?.income?.welfareAid ?? "",
      //dropdown
      'genderDesc': owner?.gender?.desc ?? "",
      'genderCode': owner?.gender?.code ?? "",
      'raceDesc': owner?.race?.desc ?? "",
      'raceCode': owner?.race?.code ?? "",
      'occupationTypeDesc': owner?.occupation?.type ?? "",
      'occupationTypeCode': owner?.occupation?.typeCode ?? "",
      'maritalStatusDesc': owner?.maritalStatus?.desc ?? "",
      'maritalStatusCode': owner?.maritalStatus?.code ?? "",
    };
  }

  List<Map<String, dynamic>> toDependantChildJson() {
    return dependants?.child == null || (dependants?.child?.isEmpty ?? true)
        ? <Map<String, dynamic>>[]
        : List<Map<String, dynamic>>.from(dependants!.child!
            .map((x) => x.toDepandantJson(censusCode: censusCode)));
  }

  List<Map<String, dynamic>> toDependantOtherJson() {
    return dependants?.others == null || (dependants?.others?.isEmpty ?? true)
        ? <Map<String, dynamic>>[]
        : List<Map<String, dynamic>>.from(
            dependants!.others!.map((x) => x.toDepandantJson()));
  }

  List<Map<String, dynamic>> toListSpouseJson() {
    return spouse == null || (spouse?.isEmpty ?? true)
        ? <Map<String, dynamic>>[]
        : List<Map<String, dynamic>>.from(spouse!.map((x) => x.toSpouseJson(
            censCode: censusCode, totalHousehold: owner?.totalHousehold)));
  }
}

class DependantsModel {
  List<DependantsData>? child;
  List<DependantsData>? others;

  DependantsModel({
    this.child,
    this.others,
  });

  DependantsModel copyWith({
    List<DependantsData>? child,
    List<DependantsData>? others,
  }) =>
      DependantsModel(
        child: child ?? this.child,
        others: others ?? this.others,
      );

  factory DependantsModel.fromJson(Map<String, dynamic> json) =>
      DependantsModel(
        child: json["child"] == null ||
                (json["child"] is List && json["child"].isEmpty)
            ? []
            : List<DependantsData>.from(
                json["child"]!.map((x) => DependantsData.fromJson(x))),
        others: json["others"] == null ||
                (json["others"] is List && json["others"].isEmpty)
            ? []
            : List<DependantsData>.from(
                json["others"]!.map((x) => DependantsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "child": (child == null || (child?.isEmpty ?? true))
            ? []
            : List<dynamic>.from(child!.map((x) => x.toJson())),
        "others": (others == null || (others?.isEmpty ?? true))
            ? []
            : List<dynamic>.from(others!.map((x) => x.toJson())),
      };
}

class SpouseData {
  String? name;
  String? icNo;
  String? email;
  String? age;
  String? phoneNo;
  String? isAlive;

  GeneralData? race;
  GeneralData? gender;
  GeneralData? healthLevel;
  String? isOku;
  OccupationData? occupation;
  IncomeData? income;

  SpouseData({
    this.name,
    this.icNo,
    this.email,
    this.age,
    this.phoneNo,
    this.isAlive,
    this.race,
    this.gender,
    this.healthLevel,
    this.isOku,
    this.occupation,
    this.income,
  });

  SpouseData copyWith({
    String? code,
    String? name,
    String? icNo,
    String? email,
    String? age,
    String? phoneNo,
    String? isAlive,
    GeneralData? race,
    GeneralData? gender,
    GeneralData? healthLevel,
    String? isOku,
    OccupationData? occupation,
    IncomeData? income,
  }) =>
      SpouseData(
        name: name ?? this.name,
        icNo: icNo ?? this.icNo,
        email: email ?? this.email,
        age: age ?? this.age,
        phoneNo: phoneNo ?? this.phoneNo,
        isAlive: isAlive ?? this.isAlive,
        race: race ?? this.race,
        gender: gender ?? this.gender,
        healthLevel: healthLevel ?? this.healthLevel,
        isOku: isOku ?? this.isOku,
        occupation: occupation ?? this.occupation,
        income: income ?? this.income,
      );

  factory SpouseData.fromJson(Map<String, dynamic> json) => SpouseData(
        name: json["name"],
        icNo: json["icNo"],
        email: json["email"],
        age: json["age"],
        phoneNo: json["phoneNo"],
        isAlive: json["isAlive"],
        race: json["race"] == null ? null : GeneralData.fromJson(json["race"]),
        gender: json["gender"] == null
            ? null
            : GeneralData.fromJson(json["gender"]),
        healthLevel: json["healthLevel"] == null
            ? null
            : GeneralData.fromJson(json["healthLevel"]),
        isOku: json["isOku"],
        occupation: json["occupation"] == null
            ? null
            : OccupationData.fromJson(json["occupation"]),
        income:
            json["income"] == null ? null : IncomeData.fromJson(json["income"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "icNo": icNo,
        "email": email,
        "age": age,
        "phoneNo": phoneNo,
        "isAlive": isAlive,
        "race": race?.toJson(),
        "gender": gender?.toJson(),
        "healthLevel": healthLevel?.toJson(),
        "isOku": isOku,
        "occupation": occupation?.toJson(),
        "income": income?.toJson(),
      };

  Map<String, dynamic> toSpouseJson(
      {String? censCode, String? totalHousehold}) {
    return {
      'censusCode': censCode,
      'icNo': icNo ?? "",
      'name': name ?? "",
      'email': email ?? "",
      "age": age ?? "",
      "phoneNo": phoneNo ?? "",
      'totalHousehold': totalHousehold ?? "",
      'healthLevelCode': healthLevel?.code ?? "",
      'healthLevelDesc': healthLevel?.desc ?? "",
      'workAddress': occupation?.workplace?.address ?? "",
      'workSalary': income?.basicSalary ?? "",
      'workAllowance': income?.allowance ?? "",
      'workOtherIncome': income?.other ?? "",
      'welfareAid': income?.welfareAid ?? "",
      'genderCode': gender?.code ?? "",
      'genderDesc': gender?.desc ?? "",
      'raceCode': race?.code ?? "",
      'raceDesc': race?.desc ?? "",
      'occupationTypeDesc': occupation?.type ?? "",
      'occupationTypeCode': occupation?.typeCode ?? "",
      'maritalStatusCode': "",
      'maritalStatusDesc': "",
      'isOku': (isOku == null || (isOku?.isEmpty ?? true)) ? "0" : isOku,
      'isAlive':
          (isAlive == null || (isAlive?.isEmpty ?? true)) ? "1" : isAlive,
    };
  }
}

class DependantsData {
  String? code;
  String? name;
  String? icNo;
  String? email;
  String? age;
  String? phoneNo;
  GeneralData? relationship;
  GeneralData? race;
  GeneralData? gender;
  GeneralData? healthLevel;
  String? isOku;

  DependantsData({
    this.code,
    this.name,
    this.icNo,
    this.email,
    this.age,
    this.phoneNo,
    this.relationship,
    this.race,
    this.gender,
    this.healthLevel,
    this.isOku,
  });

  DependantsData copyWith({
    String? code,
    String? name,
    String? icNo,
    String? email,
    String? age,
    String? phoneNo,
    GeneralData? relationship,
    GeneralData? race,
    GeneralData? gender,
    GeneralData? healthLevel,
    String? isOku,
  }) =>
      DependantsData(
        code: code ?? this.code,
        name: name ?? this.name,
        icNo: icNo ?? this.icNo,
        email: email ?? this.email,
        age: age ?? this.age,
        phoneNo: phoneNo ?? this.phoneNo,
        relationship: relationship ?? this.relationship,
        race: race ?? this.race,
        gender: gender ?? this.gender,
        healthLevel: healthLevel ?? this.healthLevel,
        isOku: isOku ?? this.isOku,
      );

  factory DependantsData.fromJson(Map<String, dynamic> json) => DependantsData(
        code: json["code"],
        name: json["name"],
        icNo: json["icNo"],
        email: json["email"],
        age: json["age"],
        phoneNo: json["phoneNo"],
        relationship: json["relationship"] == null
            ? null
            : GeneralData.fromJson(json["relationship"]),
        race: json["race"] == null ? null : GeneralData.fromJson(json["race"]),
        gender: json["gender"] == null
            ? null
            : GeneralData.fromJson(json["gender"]),
        healthLevel: json["healthLevel"] == null
            ? null
            : GeneralData.fromJson(json["healthLevel"]),
        isOku: json["isOku"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "icNo": icNo,
        "email": email,
        "age": age,
        "phoneNo": phoneNo,
        "relationship": relationship?.toJson(),
        "race": race?.toJson(),
        "gender": gender?.toJson(),
        "healthLevel": healthLevel?.toJson(),
        "isOku": isOku,
      };

  Map<String, dynamic> toDepandantJson({String? censusCode}) {
    return {
      'censusCode': censusCode,
      'icNo': icNo ?? "",
      'name': name ?? "",
      'email': email ?? "",
      "age": age ?? "",
      "phoneNo": phoneNo ?? "",
      'relationshipCode': relationship?.code ?? "",
      'relationshipDesc': relationship?.desc ?? "",
      'healthLevelCode': healthLevel?.code ?? "",
      'healthLevelDesc': healthLevel?.desc ?? "",
      'genderCode': gender?.code ?? "",
      'genderDesc': gender?.desc ?? "",
      'raceCode': race?.code ?? "",
      'raceDesc': race?.desc ?? "",
      'isOku': (isOku == null || (isOku?.isEmpty ?? true)) ? "0" : isOku,
    };
  }
}

class GeneralData {
  String? code;
  String? desc;

  GeneralData({
    this.code,
    this.desc,
  });

  GeneralData copyWith({
    String? code,
    String? desc,
  }) =>
      GeneralData(
        code: code ?? this.code,
        desc: desc ?? this.desc,
      );

  factory GeneralData.fromJson(Map<String, dynamic> json) => GeneralData(
        code: json["code"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
      };
}

class IncomeData {
  String? basicSalary;
  String? allowance;
  String? other;
  String? welfareAid;

  IncomeData({
    this.basicSalary,
    this.allowance,
    this.other,
    this.welfareAid,
  });

  IncomeData copyWith({
    String? basicSalary,
    String? allowance,
    String? other,
    String? welfareAid,
  }) =>
      IncomeData(
        basicSalary: basicSalary ?? this.basicSalary,
        allowance: allowance ?? this.allowance,
        other: other ?? this.other,
        welfareAid: welfareAid ?? this.welfareAid,
      );

  factory IncomeData.fromJson(Map<String, dynamic> json) => IncomeData(
        basicSalary: json["basicSalary"],
        allowance: json["allowance"],
        other: json["other"],
        welfareAid: json["welfareAid"],
      );

  Map<String, dynamic> toJson() => {
        "basicSalary": basicSalary,
        "allowance": allowance,
        "other": other,
        "welfareAid": welfareAid,
      };
}

class OccupationData {
  String? type;
  String? typeCode;
  WorkplaceData? workplace;

  OccupationData({
    this.type,
    this.typeCode,
    this.workplace,
  });

  OccupationData copyWith({
    String? type,
    String? typeCode,
    WorkplaceData? workplace,
  }) =>
      OccupationData(
        type: type ?? this.type,
        typeCode: typeCode ?? this.typeCode,
        workplace: workplace ?? this.workplace,
      );

  factory OccupationData.fromJson(Map<String, dynamic> json) => OccupationData(
        type: json["type"],
        typeCode: json["typeCode"],
        workplace: json["workplace"] == null
            ? null
            : WorkplaceData.fromJson(json["workplace"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "typeCode": typeCode,
        "workplace": workplace?.toJson(),
      };
}

class WorkplaceData {
  String? address;

  WorkplaceData({
    this.address,
  });

  WorkplaceData copyWith({
    String? address,
  }) =>
      WorkplaceData(
        address: address ?? this.address,
      );

  factory WorkplaceData.fromJson(Map<String, dynamic> json) => WorkplaceData(
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
      };
}

class OwnerData {
  String? name;
  String? totalHousehold;
  String? icNo;
  String? email;
  String? age;
  String? phoneNo;
  GeneralData? race;
  GeneralData? gender;
  GeneralData? healthLevel;
  OccupationData? occupation;
  IncomeData? income;
  GeneralData? maritalStatus;
  String? isOku;

  OwnerData({
    this.name,
    this.totalHousehold,
    this.icNo,
    this.email,
    this.age,
    this.phoneNo,
    this.race,
    this.gender,
    this.healthLevel,
    this.occupation,
    this.income,
    this.maritalStatus,
    this.isOku,
  });

  OwnerData copyWith({
    String? name,
    String? totalHousehold,
    String? icNo,
    String? email,
    String? age,
    String? phoneNo,
    GeneralData? race,
    GeneralData? gender,
    GeneralData? healthLevel,
    OccupationData? occupation,
    IncomeData? income,
    GeneralData? maritalStatus,
    String? isOku,
  }) =>
      OwnerData(
        name: name ?? this.name,
        totalHousehold: totalHousehold ?? this.totalHousehold,
        icNo: icNo ?? this.icNo,
        email: email ?? this.email,
        age: age ?? this.age,
        phoneNo: phoneNo ?? this.phoneNo,
        race: race ?? this.race,
        gender: gender ?? this.gender,
        healthLevel: healthLevel ?? this.healthLevel,
        occupation: occupation ?? this.occupation,
        income: income ?? this.income,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        isOku: isOku ?? this.isOku,
      );

  factory OwnerData.fromJson(Map<String, dynamic> json) => OwnerData(
        name: json["name"],
        totalHousehold: json["totalHousehold"],
        icNo: json["icNo"],
        email: json["email"],
        age: json["age"],
        phoneNo: json["phoneNo"],
        race: json["race"] == null ? null : GeneralData.fromJson(json["race"]),
        gender: json["gender"] == null
            ? null
            : GeneralData.fromJson(json["gender"]),
        healthLevel: json["healthLevel"] == null
            ? null
            : GeneralData.fromJson(json["healthLevel"]),
        occupation: json["occupation"] == null
            ? null
            : OccupationData.fromJson(json["occupation"]),
        income:
            json["income"] == null ? null : IncomeData.fromJson(json["income"]),
        maritalStatus: json["maritalStatus"] == null
            ? null
            : GeneralData.fromJson(json["maritalStatus"]),
        isOku: json["isOku"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "totalHousehold": totalHousehold,
        "icNo": icNo,
        "email": email,
        "age": age,
        "phoneNo": phoneNo,
        "race": race?.toJson(),
        "gender": gender?.toJson(),
        "healthLevel": healthLevel?.toJson(),
        "occupation": occupation?.toJson(),
        "income": income?.toJson(),
        "maritalStatus": maritalStatus?.toJson(),
        "isOku": isOku,
      };
}

class UnitData {
  String? code;
  String? no;
  String? block;
  String? floor;
  String? type;
  String? status;
  String? statusCode;
  GeneralData? housingProject;

  UnitData({
    this.code,
    this.no,
    this.block,
    this.floor,
    this.type,
    this.status,
    this.statusCode,
    this.housingProject,
  });

  UnitData copyWith({
    String? code,
    String? no,
    String? block,
    String? floor,
    String? type,
    String? status,
    String? statusCode,
    GeneralData? housingProject,
  }) =>
      UnitData(
        code: code ?? this.code,
        no: no ?? this.no,
        block: block ?? this.block,
        floor: floor ?? this.floor,
        type: type ?? this.type,
        status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode,
        housingProject: housingProject ?? this.housingProject,
      );

  factory UnitData.fromJson(Map<String, dynamic> json) => UnitData(
        code: json["code"],
        no: json["no"],
        block: json["block"],
        floor: json["floor"],
        type: json["type"],
        status: json["status"],
        statusCode: json["statusCode"],
        housingProject: json["housingProject"] == null
            ? null
            : GeneralData.fromJson(json["housingProject"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "no": no,
        "block": block,
        "floor": floor,
        "type": type,
        "status": status,
        "statusCode": statusCode,
        "housingProject": housingProject?.toJson(),
      };
}

class VisitData {
  String? status;
  String? statusCode;
  DateTime? date;
  String? remark;
  String? round;

  VisitData({
    this.status,
    this.statusCode,
    this.date,
    this.remark,
    this.round,
  });

  VisitData copyWith({
    String? status,
    String? statusCode,
    DateTime? date,
    String? remark,
    String? round,
  }) =>
      VisitData(
        status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode,
        date: date ?? this.date,
        remark: remark ?? this.remark,
        round: round ?? this.round,
      );

  factory VisitData.fromJson(Map<String, dynamic> json) => VisitData(
        status: json["status"],
        statusCode: json["statusCode"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        remark: json["remark"],
        round: json["round"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "remark": remark,
        "round": round,
      };
}
