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
  String? censusStatus;
  String? housingCode;
  String? housingDesc;
  String? unitCode;
  String? unitNumber;
  String? unitType;
  String? unitStatus;
  ResidentOwner? owner;
  List<ResidentOwner>? spouse;
  List<Dependant>? dependants;
  List<Visit>? visits;

  ResidentInfoData({
    this.qrCode,
    this.censusStatus,
    this.housingCode,
    this.housingDesc,
    this.unitCode,
    this.unitNumber,
    this.unitType,
    this.unitStatus,
    this.owner,
    this.spouse,
    this.dependants,
    this.visits,
  });

  ResidentInfoData copyWith({
    String? qrCode,
    String? censusStatus,
    String? housingCode,
    String? housingDesc,
    String? unitCode,
    String? unitNumber,
    String? unitType,
    String? unitStatus,
    ResidentOwner? owner,
    List<ResidentOwner>? spouse,
    List<Dependant>? dependants,
    List<Visit>? visits,
  }) =>
      ResidentInfoData(
        qrCode: qrCode ?? this.qrCode,
        censusStatus: censusStatus ?? this.censusStatus,
        housingCode: housingCode ?? this.housingCode,
        housingDesc: housingDesc ?? this.housingDesc,
        unitCode: unitCode ?? this.unitCode,
        unitNumber: unitNumber ?? this.unitNumber,
        unitType: unitType ?? this.unitType,
        unitStatus: unitStatus ?? this.unitStatus,
        owner: owner ?? this.owner,
        spouse: spouse ?? this.spouse,
        dependants: dependants ?? this.dependants,
        visits: visits ?? this.visits,
      );

  factory ResidentInfoData.fromJson(Map<String, dynamic> json) =>
      ResidentInfoData(
        qrCode: json["qrCode"],
        censusStatus: json["censusStatus"],
        housingCode: json["housingCode"],
        housingDesc: json["housingDesc"],
        unitCode: json["unitCode"],
        unitNumber: json["unitNumber"],
        unitType: json["unitType"],
        unitStatus: json["unitStatus"],
        owner: json["owner"] == null
            ? null
            : ResidentOwner.fromJson(json["owner"]),
        spouse: json["spouse"] == null ||
                (json["spouse"] is List && json["spouse"].isEmpty)
            ? []
            : List<ResidentOwner>.from(
                json["spouse"]!.map((x) => ResidentOwner.fromJson(x))),
        dependants: json["dependants"] == null ||
                (json["dependants"] is List && json["dependants"].isEmpty)
            ? []
            : List<Dependant>.from(
                json["dependants"]!.map((x) => Dependant.fromJson(x))),
        visits: json["visits"] == null ||
                (json["visits"] is List && json["visits"].isEmpty)
            ? []
            : List<Visit>.from(json["visits"]!.map((x) => Visit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "qrCode": qrCode,
        "censusStatus": censusStatus,
        "housingCode": housingCode,
        "housingDesc": housingDesc,
        "unitCode": unitCode,
        "unitNumber": unitNumber,
        "unitType": unitType,
        "unitStatus": unitStatus,
        "owner": owner?.toJson(),
        "spouse": spouse == null
            ? []
            : List<dynamic>.from(spouse!.map((x) => x.toJson())),
        "dependants": dependants == null
            ? []
            : List<dynamic>.from(dependants!.map((x) => x.toJson())),
        "visits": visits == null
            ? []
            : List<dynamic>.from(visits!.map((x) => x.toJson())),
      };
}

class Dependant {
  String? relationship;
  String? name;
  String? icNo;
  String? phoneNo;
  String? gender;
  String? age;
  dynamic occupationType;
  String? disabilities;
  String? healthLevel;
  DependantIncome? income;

  Dependant({
    this.relationship,
    this.name,
    this.icNo,
    this.phoneNo,
    this.gender,
    this.age,
    this.occupationType,
    this.disabilities,
    this.healthLevel,
    this.income,
  });

  Dependant copyWith({
    String? relationship,
    String? name,
    String? icNo,
    String? phoneNo,
    String? gender,
    String? age,
    String? occupationType,
    String? disabilities,
    String? healthLevel,
    DependantIncome? income,
  }) =>
      Dependant(
        relationship: relationship ?? this.relationship,
        name: name ?? this.name,
        icNo: icNo ?? this.icNo,
        phoneNo: phoneNo ?? this.phoneNo,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        occupationType: occupationType ?? this.occupationType,
        disabilities: disabilities ?? this.disabilities,
        healthLevel: healthLevel ?? this.healthLevel,
        income: income ?? this.income,
      );

  factory Dependant.fromJson(Map<String, dynamic> json) => Dependant(
        relationship: json["relationship"],
        name: json["name"],
        icNo: json["icNo"],
        phoneNo: json["phoneNo"],
        gender: json["gender"],
        age: json["age"],
        occupationType: json["occupationType"],
        disabilities: json["disabilities"],
        healthLevel: json["healthLevel"],
        income: json["income"] == null
            ? null
            : DependantIncome.fromJson(json["income"]),
      );

  Map<String, dynamic> toJson() => {
        "relationship": relationship,
        "name": name,
        "icNo": icNo,
        "phoneNo": phoneNo,
        "gender": gender,
        "age": age,
        "occupationType": occupationType,
        "disabilities": disabilities,
        "healthLevel": healthLevel,
        "income": income?.toJson(),
      };
}

class DependantIncome {
  int? basicSalary;
  int? allowance;
  int? other;
  String? address;
  String? postcode;
  String? city;
  String? state;

  DependantIncome({
    this.basicSalary,
    this.allowance,
    this.other,
    this.address,
    this.postcode,
    this.city,
    this.state,
  });

  DependantIncome copyWith({
    int? basicSalary,
    int? allowance,
    int? other,
    String? address,
    String? postcode,
    String? city,
    String? state,
  }) =>
      DependantIncome(
        basicSalary: basicSalary ?? this.basicSalary,
        allowance: allowance ?? this.allowance,
        other: other ?? this.other,
        address: address ?? this.address,
        postcode: postcode ?? this.postcode,
        city: city ?? this.city,
        state: state ?? this.state,
      );

  factory DependantIncome.fromJson(Map<String, dynamic> json) =>
      DependantIncome(
        basicSalary: json["basicSalary"],
        allowance: json["allowance"],
        other: json["other"],
        address: json["address"],
        postcode: json["postcode"],
        city: json["city"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "basicSalary": basicSalary,
        "allowance": allowance,
        "other": other,
        "address": address,
        "postcode": postcode,
        "city": city,
        "state": state,
      };
}

class ResidentOwner {
  String? name;
  String? icNo;
  String? phoneNo;
  String? email;
  String? race;
  String? gender;
  String? age;
  String? occupationType;
  String? maritalStatus;
  String? disabilities;
  OwnerIncome? income;
  List<WelfareAid>? welfareAid;
  String? healthLevel;

  ResidentOwner({
    this.name,
    this.icNo,
    this.phoneNo,
    this.email,
    this.race,
    this.gender,
    this.age,
    this.occupationType,
    this.maritalStatus,
    this.disabilities,
    this.income,
    this.welfareAid,
    this.healthLevel,
  });

  ResidentOwner copyWith({
    String? name,
    String? icNo,
    String? phoneNo,
    String? email,
    String? race,
    String? gender,
    String? age,
    String? occupationType,
    String? maritalStatus,
    String? disabilities,
    OwnerIncome? income,
    List<WelfareAid>? welfareAid,
    String? healthLevel,
  }) =>
      ResidentOwner(
        name: name ?? this.name,
        icNo: icNo ?? this.icNo,
        phoneNo: phoneNo ?? this.phoneNo,
        email: email ?? this.email,
        race: race ?? this.race,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        occupationType: occupationType ?? this.occupationType,
        maritalStatus: maritalStatus ?? this.maritalStatus,
        disabilities: disabilities ?? this.disabilities,
        income: income ?? this.income,
        welfareAid: welfareAid ?? this.welfareAid,
        healthLevel: healthLevel ?? this.healthLevel,
      );

  factory ResidentOwner.fromJson(Map<String, dynamic> json) => ResidentOwner(
        name: json["name"],
        icNo: json["icNo"],
        phoneNo: json["phoneNo"],
        email: json["email"],
        race: json["race"],
        gender: json["gender"],
        age: json["age"],
        occupationType: json["occupationType"],
        maritalStatus: json["maritalStatus"],
        disabilities: json["disabilities"],
        income: json["income"] == null
            ? null
            : OwnerIncome.fromJson(json["income"]),
        welfareAid: json["welfareAid"] == null
            ? []
            : List<WelfareAid>.from(
                json["welfareAid"]!.map((x) => WelfareAid.fromJson(x))),
        healthLevel: json["healthLevel"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "icNo": icNo,
        "phoneNo": phoneNo,
        "email": email,
        "race": race,
        "gender": gender,
        "age": age,
        "occupationType": occupationType,
        "maritalStatus": maritalStatus,
        "disabilities": disabilities,
        "income": income?.toJson(),
        "welfareAid": welfareAid == null
            ? []
            : List<dynamic>.from(welfareAid!.map((x) => x.toJson())),
        "healthLevel": healthLevel,
      };
}

class OwnerIncome {
  String? basicSalary;
  String? allowance;
  String? other;
  String? address;
  String? postcode;
  String? city;
  String? state;

  OwnerIncome({
    this.basicSalary,
    this.allowance,
    this.other,
    this.address,
    this.postcode,
    this.city,
    this.state,
  });

  OwnerIncome copyWith({
    String? basicSalary,
    String? allowance,
    String? other,
    String? address,
    String? postcode,
    String? city,
    String? state,
  }) =>
      OwnerIncome(
        basicSalary: basicSalary ?? this.basicSalary,
        allowance: allowance ?? this.allowance,
        other: other ?? this.other,
        address: address ?? this.address,
        postcode: postcode ?? this.postcode,
        city: city ?? this.city,
        state: state ?? this.state,
      );

  factory OwnerIncome.fromJson(Map<String, dynamic> json) => OwnerIncome(
        basicSalary: json["basicSalary"],
        allowance: json["allowance"],
        other: json["other"],
        address: json["address"],
        postcode: json["postcode"],
        city: json["city"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "basicSalary": basicSalary,
        "allowance": allowance,
        "other": other,
        "address": address,
        "postcode": postcode,
        "city": city,
        "state": state,
      };
}

class WelfareAid {
  String? desc;
  String? amount;

  WelfareAid({
    this.desc,
    this.amount,
  });

  WelfareAid copyWith({
    String? desc,
    String? amount,
  }) =>
      WelfareAid(
        desc: desc ?? this.desc,
        amount: amount ?? this.amount,
      );

  factory WelfareAid.fromJson(Map<String, dynamic> json) => WelfareAid(
        desc: json["desc"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "desc": desc,
        "amount": amount,
      };
}

class Visit {
  String? status;
  String? remark;
  String? round;

  Visit({
    this.status,
    this.remark,
    this.round,
  });

  Visit copyWith({
    String? status,
    String? remark,
    String? round,
  }) =>
      Visit(
        status: status ?? this.status,
        remark: remark ?? this.remark,
        round: round ?? this.round,
      );

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
        status: json["status"],
        remark: json["remark"],
        round: json["round"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "remark": remark,
        "round": round,
      };
}
