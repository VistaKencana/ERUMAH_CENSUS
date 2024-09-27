import 'dart:typed_data';

class OwnerInputModel {
  String cencusCode;
  String isNotOwner;
  String totalHousehold;
  String email;
  String phoneNo;
  String occupationTypeCode;
  String maritalStatusCode;
  String isOku;
  String workAddress;
  String workSalary;
  String workAllowance;
  String workOtherIncome;
  String welfareAid;
  Uint8List? uploadIncome;
  Uint8List? uploadIcFront;
  Uint8List? uploadIcBack;
  Uint8List? uploadOkuCard;

  OwnerInputModel({
    required this.cencusCode,
    required this.isNotOwner,
    required this.totalHousehold,
    required this.email,
    required this.phoneNo,
    required this.occupationTypeCode,
    required this.maritalStatusCode,
    required this.isOku,
    required this.workAddress,
    required this.workSalary,
    required this.workAllowance,
    required this.workOtherIncome,
    required this.welfareAid,
    this.uploadIncome,
    this.uploadIcFront,
    this.uploadIcBack,
    this.uploadOkuCard,
  });

  // CopyWith method
  OwnerInputModel copyWith({
    String? cencusCode,
    String? isNotOwner,
    String? totalHousehold,
    String? email,
    String? phoneNo,
    String? occupationTypeCode,
    String? maritalStatusCode,
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
  }) {
    return OwnerInputModel(
      cencusCode: cencusCode ?? this.cencusCode,
      isNotOwner: isNotOwner ?? this.isNotOwner,
      totalHousehold: totalHousehold ?? this.totalHousehold,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      occupationTypeCode: occupationTypeCode ?? this.occupationTypeCode,
      maritalStatusCode: maritalStatusCode ?? this.maritalStatusCode,
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
    );
  }

  // ToJson method
  Map<String, String> toJson() {
    return {
      'cencusCode': cencusCode,
      'isNotOwner': isNotOwner,
      'totalHousehold': totalHousehold,
      'email': email,
      'phoneNo': phoneNo,
      'occupationTypeCode': occupationTypeCode,
      'maritalStatusCode': maritalStatusCode,
      'isOku': isOku,
      'workAddress': workAddress,
      'workSalary': workSalary,
      'workAllowance': workAllowance,
      'workOtherIncome': workOtherIncome,
      'welfareAid': welfareAid
    };
  }

  Map<String, Uint8List?> getFiles() {
    return {
      'uploadIncome': uploadIncome,
      'uploadIcFront': uploadIcFront,
      'uploadIcBack': uploadIcBack,
      'uploadOkuCard': uploadOkuCard
    };
  }

  factory OwnerInputModel.fromJson(Map<String, dynamic> json) {
    return OwnerInputModel(
      cencusCode: json['cencusCode'] as String,
      isNotOwner: json['isNotOwner'] as String,
      totalHousehold: json['totalHousehold'] as String,
      email: json['email'] as String,
      phoneNo: json['phoneNo'] as String,
      occupationTypeCode: json['occupationTypeCode'] as String,
      maritalStatusCode: json['maritalStatusCode'] as String,
      isOku: json['isOku'] as String,
      workAddress: json['workAddress'] as String,
      workSalary: json['workSalary'] as String,
      workAllowance: json['workAllowance'] as String,
      workOtherIncome: json['workOtherIncome'] as String,
      welfareAid: json['welfareAid'] as String,
    );
  }
}
