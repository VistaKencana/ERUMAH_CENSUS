import 'dart:typed_data';

class SubrentInputModel {
  String? censusCode;
  String? name;
  String? icNo;
  String? phoneNo;
  String? email;
  String? raceCode;
  String? genderCode;
  String? healthLevelCode;
  String? isOku;
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

  SubrentInputModel({
    this.censusCode,
    this.name,
    this.icNo,
    this.phoneNo,
    this.email,
    this.raceCode,
    this.genderCode,
    this.healthLevelCode,
    this.isOku,
    this.uploadIcFront,
    this.uploadIcBack,
    this.uploadOkuCard,
    //dd (optional)
    this.raceDesc,
    this.genderDesc,
    this.occupationTypeDesc,
    this.maritalStatusDesc,
    this.healthLevelDesc,
    //Used for validation
    this.isChangeOnImage = false,
  });

  // From JSON
  factory SubrentInputModel.fromJson(Map<String, dynamic> json) {
    return SubrentInputModel(
      censusCode: json['censusCode'] as String,
      name: json['name'] as String,
      icNo: json['icNo'] as String,
      phoneNo: json['phoneNo'] as String,
      email: json['email'] as String,
      raceCode: json['raceCode'] as String,
      genderCode: json['genderCode'] as String,
      healthLevelCode: json['healthLevelCode'] as String,
      isOku: json['isOku'] as String,
    );
  }

  // To JSON
  Map<String, String> toJson() {
    return {
      'censusCode': censusCode ?? "",
      'name': name ?? "",
      'icNo': icNo ?? "",
      'phoneNo': phoneNo ?? "",
      'email': email ?? "",
      'raceCode': raceCode ?? "",
      'genderCode': genderCode ?? "",
      'healthLevelCode': healthLevelCode ?? "",
      'isOku': isOku ?? "",
    };
  }

  Map<String, Uint8List?> getFiles() {
    return {
      'uploadIcFront': uploadIcFront,
      'uploadIcBack': uploadIcBack,
      'uploadOkuCard': isOku == "0" ? null : uploadOkuCard,
    };
  }

  Map<String, String> toValidate() {
    return {
      'censusCode': censusCode ?? "",
      'name': name ?? "",
      'icNo': icNo ?? "",
      'email': email ?? "",
      'phoneNo': phoneNo ?? "",
      'raceCode': raceCode ?? "",
      'genderCode': genderCode ?? "",
      'healthLevelCode': healthLevelCode ?? "",
      'isOku': isOku ?? "",
      'isChangeOnImage': "$isChangeOnImage",
    };
  }

  SubrentInputModel copyWith({
    String? censusCode,
    String? name,
    String? icNo,
    String? phoneNo,
    String? email,
    String? raceCode,
    String? genderCode,
    String? healthLevelCode,
    String? isOku,
    Uint8List? uploadIcFront,
    Uint8List? uploadIcBack,
    Uint8List? uploadOkuCard,
    bool? isChangeOnImage,
    //dd (optional)
    String? raceDesc,
    String? genderDesc,
    String? occupationTypeDesc,
    String? maritalStatusDesc,
    String? healthLevelDesc,
  }) {
    return SubrentInputModel(
      censusCode: censusCode ?? this.censusCode,
      name: name ?? this.name,
      icNo: icNo ?? this.icNo,
      phoneNo: phoneNo ?? this.phoneNo,
      email: email ?? this.email,
      raceCode: raceCode ?? this.raceCode,
      genderCode: genderCode ?? this.genderCode,
      healthLevelCode: healthLevelCode ?? this.healthLevelCode,
      isOku: isOku ?? this.isOku,
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
}
