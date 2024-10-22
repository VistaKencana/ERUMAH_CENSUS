import 'dart:typed_data';

class SpouseInputModel {
  final String? censusCode;
  final String? icNo;
  final String? name;
  final String? email;
  final String? phoneNo;
  final String? age;
  final String? totalHousehold;
  final String? healthLevelCode;
  final String? companyName;
  final String? workAddress;
  final String? workSalary;
  final String? workAllowance;
  final String? workOtherIncome;
  final String? welfareAid;
  final String? genderCode;
  final String? raceCode;
  final String? occupationTypeCode;
  final String? maritalStatusCode;
  final String isOku;
  final String isAlive;
  final Uint8List? uploadIncome;
  final Uint8List? uploadIcFront;
  final Uint8List? uploadIcBack;
  final Uint8List? uploadOkuCard;
  //dd (optional)
  String? raceDesc;
  String? genderDesc;
  String? occupationTypeDesc;
  String? maritalStatusDesc;
  String? healthLevelDesc;
  //For validate changes
  bool isChangeOnImage;

  SpouseInputModel({
    this.censusCode,
    this.icNo,
    this.name,
    this.email,
    this.phoneNo,
    this.age,
    this.totalHousehold,
    this.healthLevelCode,
    this.companyName,
    this.workAddress,
    this.workSalary,
    this.workAllowance,
    this.workOtherIncome,
    this.welfareAid,
    this.genderCode,
    this.raceCode,
    this.occupationTypeCode,
    this.maritalStatusCode,
    this.isOku = "0",
    this.isAlive = "1",
    this.uploadIncome,
    this.uploadIcFront,
    this.uploadIcBack,
    this.uploadOkuCard,
    //dd (optional)
    this.raceDesc,
    this.genderDesc,
    this.maritalStatusDesc,
    this.occupationTypeDesc,
    this.healthLevelDesc,
    //For validate changes
    this.isChangeOnImage = false,
  });

  SpouseInputModel copyWith({
    String? censusCode,
    String? icNo,
    String? name,
    String? email,
    String? phoneNo,
    String? age,
    String? totalHousehold,
    String? healthLevelCode,
    String? companyName,
    String? workAddress,
    String? workSalary,
    String? workAllowance,
    String? workOtherIncome,
    String? welfareAid,
    String? genderCode,
    String? raceCode,
    String? occupationTypeCode,
    String? maritalStatusCode,
    String? isOku,
    String? isAlive,
    Uint8List? uploadIncome,
    Uint8List? uploadIcFront,
    Uint8List? uploadIcBack,
    Uint8List? uploadOkuCard,
    String? raceDesc,
    String? genderDesc,
    String? occupationTypeDesc,
    String? maritalStatusDesc,
    String? healthLevelDesc,
    bool? isChangeOnImage,
  }) {
    return SpouseInputModel(
      censusCode: censusCode ?? this.censusCode,
      icNo: icNo ?? this.icNo,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      age: age ?? this.age,
      totalHousehold: totalHousehold ?? this.totalHousehold,
      healthLevelCode: healthLevelCode ?? this.healthLevelCode,
      companyName: companyName ?? this.companyName,
      workAddress: workAddress ?? this.workAddress,
      workSalary: workSalary ?? this.workSalary,
      workAllowance: workAllowance ?? this.workAllowance,
      workOtherIncome: workOtherIncome ?? this.workOtherIncome,
      welfareAid: welfareAid ?? this.welfareAid,
      genderCode: genderCode ?? this.genderCode,
      raceCode: raceCode ?? this.raceCode,
      occupationTypeCode: occupationTypeCode ?? this.occupationTypeCode,
      maritalStatusCode: maritalStatusCode ?? this.maritalStatusCode,
      isOku: isOku ?? this.isOku,
      isAlive: isAlive ?? this.isAlive,
      uploadIncome: uploadIncome ?? this.uploadIncome,
      uploadIcFront: uploadIcFront ?? this.uploadIcFront,
      uploadIcBack: uploadIcBack ?? this.uploadIcBack,
      uploadOkuCard: uploadOkuCard ?? this.uploadOkuCard,
      raceDesc: raceDesc ?? this.raceDesc,
      genderDesc: genderDesc ?? this.genderDesc,
      occupationTypeDesc: occupationTypeDesc ?? this.occupationTypeDesc,
      maritalStatusDesc: maritalStatusDesc ?? this.maritalStatusDesc,
      healthLevelDesc: healthLevelDesc ?? this.healthLevelDesc,
      isChangeOnImage: isChangeOnImage ?? this.isChangeOnImage,
    );
  }

  Map<String, String> toJson() {
    return {
      'censusCode': censusCode ?? "",
      'icNo': icNo ?? "",
      'name': name ?? "",
      'email': email ?? "",
      'phoneNo': phoneNo ?? "",
      'isAlive': isAlive,
      'totalHousehold': totalHousehold ?? "",
      'healthLevelCode': healthLevelCode ?? "",
      'companyName': companyName ?? "",
      'workAddress': workAddress ?? "",
      'workSalary': workSalary ?? "",
      'workAllowance': workAllowance ?? "",
      'workOtherIncome': workOtherIncome ?? "",
      'welfareAid': welfareAid ?? "",
      'genderCode': genderCode ?? "",
      'raceCode': raceCode ?? "",
      'occupationTypeCode': occupationTypeCode ?? "",
      'maritalStatusCode': maritalStatusCode ?? "",
      'isOku': isOku,
    };
  }

  Map<String, String> toValidate() {
    return {
      'censusCode': censusCode ?? "",
      'icNo': icNo ?? "",
      'name': name ?? "",
      'email': email ?? "",
      'phoneNo': phoneNo ?? "",
      'isAlive': isAlive,
      'totalHousehold': totalHousehold ?? "",
      'healthLevelCode': healthLevelCode ?? "",
      'companyName': companyName ?? "",
      'workAddress': workAddress ?? "",
      'workSalary': workSalary ?? "",
      'workAllowance': workAllowance ?? "",
      'workOtherIncome': workOtherIncome ?? "",
      'welfareAid': welfareAid ?? "",
      'genderCode': genderCode ?? "",
      'raceCode': raceCode ?? "",
      'occupationTypeCode': occupationTypeCode ?? "",
      'maritalStatusCode': maritalStatusCode ?? "",
      'isOku': isOku,
      'isChangeOnImage': "$isChangeOnImage",
    };
  }

  Map<String, Uint8List?> getFiles() {
    return {
      'uploadIncome': uploadIncome,
      'uploadIcFront': uploadIcFront,
      'uploadIcBack': uploadIcBack,
      'uploadOkuCard': uploadOkuCard,
    };
  }

  // FromJson method
  factory SpouseInputModel.fromJson(Map<String, dynamic> json) {
    return SpouseInputModel(
      censusCode: json['censusCode'] as String,
      icNo: json['icNo'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNo: json['phoneNo'] as String,
      age: json['age'] as String,
      totalHousehold: json['totalHousehold'] as String,
      healthLevelCode: json['healthLevelCode'] as String,
      companyName: json['companyName'] as String,
      workAddress: json['workAddress'] as String,
      workSalary: json['workSalary'] as String,
      workAllowance: json['workAllowance'] as String,
      workOtherIncome: json['workOtherIncome'] as String,
      welfareAid: json['welfareAid'] as String,
      genderCode: json['genderCode'] as String,
      genderDesc: json['genderDesc'] as String,
      raceCode: json['raceCode'] as String,
      raceDesc: json['raceDesc'] as String,
      occupationTypeDesc: json['occupationTypeDesc'] as String,
      occupationTypeCode: json['occupationTypeCode'] as String,
      maritalStatusCode: json['maritalStatusCode'] as String,
      maritalStatusDesc: json['maritalStatusDesc'] as String,
      healthLevelDesc: json['healthLevelDesc'] as String,
      isOku: json['isOku'] as String,
      isAlive: json['isAlive'] as String,
    );
  }
}
