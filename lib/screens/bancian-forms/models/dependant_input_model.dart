import 'dart:typed_data';

class DependantInputModel {
  final String censusCode;
  final String icNo;
  final String name;
  final String email;
  final String relationshipCode;
  final String relationshipDesc;
  final String healthLevelCode;
  final String healthLevelDesc;
  final String genderCode;
  final String genderDesc;
  final String raceCode;
  final String raceDesc;
  final String isOku;
  final Uint8List? uploadIncome;
  final Uint8List? uploadIcFront;
  final Uint8List? uploadIcBack;
  final Uint8List? uploadOkuCard;

  DependantInputModel({
    required this.censusCode,
    required this.icNo,
    required this.name,
    required this.email,
    required this.relationshipCode,
    required this.relationshipDesc,
    required this.healthLevelCode,
    required this.healthLevelDesc,
    required this.genderCode,
    required this.genderDesc,
    required this.raceCode,
    required this.raceDesc,
    required this.isOku,
    this.uploadIncome,
    this.uploadIcFront,
    this.uploadIcBack,
    this.uploadOkuCard,
  });

  DependantInputModel copyWith({
    String? censusCode,
    String? icNo,
    String? name,
    String? email,
    String? relationshipCode,
    String? relationshipDesc,
    String? healthLevelCode,
    String? healthLevelDesc,
    String? genderCode,
    String? genderDesc,
    String? raceCode,
    String? raceDesc,
    String? isOku,
    Uint8List? uploadIncome,
    Uint8List? uploadIcFront,
    Uint8List? uploadIcBack,
    Uint8List? uploadOkuCard,
  }) {
    return DependantInputModel(
      censusCode: censusCode ?? this.censusCode,
      icNo: icNo ?? this.icNo,
      name: name ?? this.name,
      email: email ?? this.email,
      relationshipCode: relationshipCode ?? this.relationshipCode,
      relationshipDesc: relationshipDesc ?? this.relationshipDesc,
      healthLevelCode: healthLevelCode ?? this.healthLevelCode,
      healthLevelDesc: healthLevelDesc ?? this.healthLevelDesc,
      genderCode: genderCode ?? this.genderCode,
      genderDesc: genderDesc ?? this.genderDesc,
      raceCode: raceCode ?? this.raceCode,
      raceDesc: raceDesc ?? this.raceDesc,
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
      'relationshipCode': relationshipCode,
      'healthLevelCode': healthLevelCode,
      'genderCode': genderCode,
      'raceCode': raceCode,
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
  factory DependantInputModel.fromJson(Map<String, dynamic> json) {
    return DependantInputModel(
      censusCode: json['censusCode'] ?? "",
      icNo: json['icNo'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      relationshipCode: json['relationshipCode'] ?? "",
      relationshipDesc: json['relationshipDesc'] ?? "",
      healthLevelCode: json['healthLevelCode'] ?? "",
      healthLevelDesc: json['healthLevelDesc'] ?? "",
      genderCode: json['genderCode'] ?? "",
      genderDesc: json['genderDesc'] ?? "",
      raceCode: json['raceCode'] ?? "",
      raceDesc: json['raceDesc'] ?? "",
      isOku: json['isOku'] ?? "",
    );
  }
}
