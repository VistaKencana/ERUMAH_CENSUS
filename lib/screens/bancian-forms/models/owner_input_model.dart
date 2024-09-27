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
  String isHasWelfareAid;
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
    required this.isHasWelfareAid,
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
    String? isHasWelfareAid,
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
      isHasWelfareAid: isHasWelfareAid ?? this.isHasWelfareAid,
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
      'isHasWelfareAid': isHasWelfareAid
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
}
