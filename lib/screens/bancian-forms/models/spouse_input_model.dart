import 'dart:typed_data';

class SpouseInputModel {
  final String censusCode;
  final String icNo;
  final String name;
  final String email;
  final String totalHousehold;
  final String healthLevelCode;
  final String workAddress;
  final String workSalary;
  final String workAllowance;
  final String workOtherIncome;
  final String welfareAid;
  final String genderCode;
  final String raceCode;
  final String occupationTypeCode;
  final String isOku;
  final Uint8List? uploadIncome;
  final Uint8List? uploadIcFront;
  final Uint8List? uploadIcBack;
  final Uint8List? uploadOkuCard;

  SpouseInputModel({
    required this.censusCode,
    required this.icNo,
    required this.name,
    required this.email,
    required this.totalHousehold,
    required this.healthLevelCode,
    required this.workAddress,
    required this.workSalary,
    required this.workAllowance,
    required this.workOtherIncome,
    required this.welfareAid,
    required this.genderCode,
    required this.raceCode,
    required this.occupationTypeCode,
    required this.isOku,
    this.uploadIncome,
    this.uploadIcFront,
    this.uploadIcBack,
    this.uploadOkuCard,
  });

  SpouseInputModel copyWith({
    String? censusCode,
    String? icNo,
    String? name,
    String? email,
    String? totalHousehold,
    String? healthLevelCode,
    String? workAddress,
    String? workSalary,
    String? workAllowance,
    String? workOtherIncome,
    String? welfareAid,
    String? genderCode,
    String? raceCode,
    String? occupationTypeCode,
    String? isOku,
    Uint8List? uploadIncome,
    Uint8List? uploadIcFront,
    Uint8List? uploadIcBack,
    Uint8List? uploadOkuCard,
  }) {
    return SpouseInputModel(
      censusCode: censusCode ?? this.censusCode,
      icNo: icNo ?? this.icNo,
      name: name ?? this.name,
      email: email ?? this.email,
      totalHousehold: totalHousehold ?? this.totalHousehold,
      healthLevelCode: healthLevelCode ?? this.healthLevelCode,
      workAddress: workAddress ?? this.workAddress,
      workSalary: workSalary ?? this.workSalary,
      workAllowance: workAllowance ?? this.workAllowance,
      workOtherIncome: workOtherIncome ?? this.workOtherIncome,
      welfareAid: welfareAid ?? this.welfareAid,
      genderCode: genderCode ?? this.genderCode,
      raceCode: raceCode ?? this.raceCode,
      occupationTypeCode: occupationTypeCode ?? this.occupationTypeCode,
      isOku: isOku ?? this.isOku,
      uploadIncome: uploadIncome ?? this.uploadIncome,
      uploadIcFront: uploadIcFront ?? this.uploadIcFront,
      uploadIcBack: uploadIcBack ?? this.uploadIcBack,
      uploadOkuCard: uploadOkuCard ?? this.uploadOkuCard,
    );
  }

  Map<String, String> toJson() {
    return {
      'censusCode': censusCode,
      'icNo': icNo,
      'name': name,
      'email': email,
      'totalHousehold': totalHousehold,
      'healthLevelCode': healthLevelCode,
      'workAddress': workAddress,
      'workSalary': workSalary,
      'workAllowance': workAllowance,
      'workOtherIncome': workOtherIncome,
      'welfareAid': welfareAid,
      'genderCode': genderCode,
      'raceCode': raceCode,
      'occupationTypeCode': occupationTypeCode,
      'isOku': isOku,
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
      totalHousehold: json['totalHousehold'] as String,
      healthLevelCode: json['healthLevelCode'] as String,
      workAddress: json['workAddress'] as String,
      workSalary: json['workSalary'] as String,
      workAllowance: json['workAllowance'] as String,
      workOtherIncome: json['workOtherIncome'] as String,
      welfareAid: json['welfareAid'] as String,
      genderCode: json['genderCode'] as String,
      raceCode: json['raceCode'] as String,
      occupationTypeCode: json['occupationTypeCode'] as String,
      isOku: json['isOku'] as String,
    );
  }
}
