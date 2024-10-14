import 'dart:typed_data';

class OwnerInputModel {
  String? censusCode;
  String? isNotOwner;
  String? name;
  String? icNo;
  String? raceCode; //dd
  String? genderCode; //dd
  String? totalHousehold;
  String? email;
  String? phoneNo;
  String? age;
  String? occupationTypeCode; //dd
  String? maritalStatusCode; //dd
  String? healthLevelCode; //dd
  String? isOku;
  String? workAddress;
  String? workSalary;
  String? workAllowance;
  String? workOtherIncome;
  String? welfareAid;
  Uint8List? uploadIncome;
  Uint8List? uploadIcFront;
  Uint8List? uploadIcBack;
  Uint8List? uploadOkuCard;
  //dd (optional)
  String? raceDesc;
  String? genderDesc;
  String? occupationTypeDesc;
  String? maritalStatusDesc;
  String? healthLevelDesc;
  //Used for validation
  bool isChangeOnImage;

  OwnerInputModel(
      {this.censusCode,
      this.isNotOwner,
      this.name,
      this.icNo,
      this.raceCode,
      this.genderCode,
      this.email,
      this.phoneNo,
      this.age,
      this.totalHousehold,
      this.occupationTypeCode,
      this.maritalStatusCode,
      this.healthLevelCode,
      this.isOku,
      this.workAddress,
      this.workSalary,
      this.workAllowance,
      this.workOtherIncome,
      this.welfareAid,
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
      //Used for validation
      this.isChangeOnImage = false});

  // CopyWith method
  OwnerInputModel copyWith({
    String? censusCode,
    String? isNotOwner,
    String? name,
    String? icNo,
    String? raceCode,
    String? genderCode,
    String? totalHousehold,
    String? email,
    String? phoneNo,
    String? age,
    String? occupationTypeCode,
    String? maritalStatusCode,
    String? healthLevelCode,
    String? isOku,
    String? workAddress,
    String? workSalary,
    String? workAllowance,
    String? workOtherIncome,
    String? welfareAid,
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
    return OwnerInputModel(
      censusCode: censusCode ?? this.censusCode,
      isNotOwner: isNotOwner ?? this.isNotOwner,
      name: name ?? this.name,
      icNo: icNo ?? this.icNo,
      raceCode: raceCode ?? this.raceCode,
      genderCode: genderCode ?? this.genderCode,
      totalHousehold: totalHousehold ?? this.totalHousehold,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      age: age ?? this.age,
      occupationTypeCode: occupationTypeCode ?? this.occupationTypeCode,
      maritalStatusCode: maritalStatusCode ?? this.maritalStatusCode,
      healthLevelCode: healthLevelCode ?? this.healthLevelCode,
      isOku: isOku ?? this.isOku,
      workAddress: workAddress ?? this.workAddress,
      workSalary: workSalary ?? this.workSalary,
      workAllowance: workAllowance ?? this.workAllowance,
      workOtherIncome: workOtherIncome ?? this.workOtherIncome,
      welfareAid: welfareAid ?? this.welfareAid,
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

  // ToJson method
  Map<String, String> toJson() {
    return {
      'censusCode': censusCode ?? "",
      'isNotOwner': isNotOwner ?? "",
      'name': name ?? "",
      'icNo': icNo ?? "",
      'email': email ?? "",
      'phoneNo': phoneNo ?? "",
      'raceCode': raceCode ?? "",
      'genderCode': genderCode ?? "",
      'totalHousehold': totalHousehold ?? "",
      'occupationTypeCode': occupationTypeCode ?? "",
      'maritalStatusCode': maritalStatusCode ?? "",
      'healthLevelCode': healthLevelCode ?? "",
      'isOku': isOku ?? "",
      'workAddress': workAddress ?? "",
      'workSalary': workSalary ?? "",
      'workAllowance': workAllowance ?? "",
      'workOtherIncome': workOtherIncome ?? "",
      'welfareAid': welfareAid ?? "",
    };
  }

  Map<String, String> toValidate() {
    return {
      'censusCode': censusCode ?? "",
      'isNotOwner': isNotOwner ?? "",
      'name': name ?? "",
      'icNo': icNo ?? "",
      'email': email ?? "",
      'phoneNo': phoneNo ?? "",
      'raceCode': raceCode ?? "",
      'genderCode': genderCode ?? "",
      'totalHousehold': totalHousehold ?? "",
      'occupationTypeCode': occupationTypeCode ?? "",
      'maritalStatusCode': maritalStatusCode ?? "",
      'healthLevelCode': healthLevelCode ?? "",
      'isOku': isOku ?? "",
      'workAddress': workAddress ?? "",
      'workSalary': workSalary ?? "",
      'workAllowance': workAllowance ?? "",
      'workOtherIncome': workOtherIncome ?? "",
      'welfareAid': welfareAid ?? "",
      'isChangeOnImage': "$isChangeOnImage",
    };
  }

  Map<String, Uint8List?> getFiles() {
    return {
      'uploadIncome': uploadIncome,
      'uploadIcFront': uploadIcFront,
      'uploadIcBack': uploadIcBack,
      'uploadOkuCard': isOku == "0" ? null : uploadOkuCard
    };
  }

  factory OwnerInputModel.fromJson(Map<String, dynamic> json) {
    return OwnerInputModel(
      censusCode: json['censusCode'] as String,
      isNotOwner: json['isNotOwner'] as String,
      name: json['name'] as String,
      icNo: json['icNo'] as String,
      totalHousehold: json['totalHousehold'] as String,
      email: json['email'] as String,
      phoneNo: json['phoneNo'] as String,
      age: json['age'] as String,
      isOku: json['isOku'] as String,
      workAddress: json['workAddress'] as String,
      workSalary: json['workSalary'] as String,
      workAllowance: json['workAllowance'] as String,
      workOtherIncome: json['workOtherIncome'] as String,
      welfareAid: json['welfareAid'] as String,
      occupationTypeDesc: json['occupationTypeDesc'] as String,
      occupationTypeCode: json['occupationTypeCode'] as String,
      maritalStatusDesc: json['maritalStatusDesc'] as String,
      maritalStatusCode: json['maritalStatusCode'] as String,
      genderDesc: json['genderDesc'] as String,
      genderCode: json['genderCode'] as String,
      raceDesc: json['raceDesc'] as String,
      raceCode: json['raceCode'] as String,
      healthLevelDesc: json['healthLevelDesc'] as String,
      healthLevelCode: json['healthLevelCode'] as String,
    );
  }

  // CopyWith method
  OwnerInputModel resetImage(CardType type) {
    return OwnerInputModel(
      censusCode: censusCode,
      isNotOwner: isNotOwner,
      name: name,
      icNo: icNo,
      raceCode: raceCode,
      genderCode: genderCode,
      totalHousehold: totalHousehold,
      email: email,
      phoneNo: phoneNo,
      age: age,
      occupationTypeCode: occupationTypeCode,
      maritalStatusCode: maritalStatusCode,
      isOku: isOku,
      workAddress: workAddress,
      workSalary: workSalary,
      workAllowance: workAllowance,
      workOtherIncome: workOtherIncome,
      welfareAid: welfareAid,
      uploadIncome: type == CardType.income ? null : uploadIncome,
      uploadIcFront: type == CardType.front ? null : uploadIcFront,
      uploadIcBack: type == CardType.back ? null : uploadIcBack,
      uploadOkuCard: type == CardType.oku ? null : uploadOkuCard,
      raceDesc: raceDesc,
      genderDesc: genderDesc,
      occupationTypeDesc: occupationTypeDesc,
      maritalStatusDesc: maritalStatusDesc,
      healthLevelCode: healthLevelCode,
      healthLevelDesc: healthLevelDesc,
    );
  }
}

enum CardType { oku, front, back, income }
