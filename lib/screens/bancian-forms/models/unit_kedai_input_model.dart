import 'dart:typed_data';

class UnitKedaiInputModel {
  final String? censusCode;
  final String? name;
  final String? icNo;
  final String? email;
  final String? phoneNo;
  final String? businessTypeCode;
  final Uint8List? uploadSSM;
  final Uint8List? uploadBusinessLicense;

  //dd (optional)
  String? businessTypeDesc;

  //For validate changes
  bool isChangeOnImage;

  UnitKedaiInputModel({
    this.censusCode,
    this.name,
    this.icNo,
    this.email,
    this.phoneNo,
    this.businessTypeCode,
    this.uploadSSM,
    this.uploadBusinessLicense,
    //dd (optional)
    this.businessTypeDesc,

    //For validate changes
    this.isChangeOnImage = false,
  });

  factory UnitKedaiInputModel.fromJson(Map<String, dynamic> json) {
    return UnitKedaiInputModel(
      censusCode: json['censusCode'] ?? '',
      name: json['name'] ?? '',
      icNo: json['icNo'] ?? '',
      email: json['email'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      businessTypeCode: json['businessTypeCode'] ?? '',
      businessTypeDesc: json['businessTypeDesc'] ?? '',
    );
  }

  Map<String, String> toJson() {
    return {
      'censusCode': censusCode ?? "",
      'name': name ?? "",
      'icNo': icNo ?? "",
      'email': email ?? "",
      'phoneNo': phoneNo ?? "",
      'businessTypeCode': businessTypeCode ?? "",
    };
  }

  Map<String, String> toValidate() {
    return {
      'censusCode': censusCode ?? "",
      'name': name ?? "",
      'icNo': icNo ?? "",
      'email': email ?? "",
      'phoneNo': phoneNo ?? "",
      'businessTypeCode': businessTypeCode ?? "",
      'isChangeOnImage': "$isChangeOnImage",
    };
  }

  Map<String, Uint8List?> getFiles() {
    return {
      'uploadSSM': uploadSSM,
      'uploadBusinessLicense': uploadBusinessLicense,
    };
  }

  UnitKedaiInputModel copyWith({
    String? censusCode,
    String? name,
    String? icNo,
    String? email,
    String? phoneNo,
    String? businessTypeCode,
    Uint8List? uploadSSM,
    Uint8List? uploadBusinessLicense,
    String? businessTypeDesc,
    bool? isChangeOnImage,
  }) {
    return UnitKedaiInputModel(
      censusCode: censusCode ?? this.censusCode,
      name: name ?? this.name,
      icNo: icNo ?? this.icNo,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      businessTypeCode: businessTypeCode ?? this.businessTypeCode,
      uploadSSM: uploadSSM ?? this.uploadSSM,
      uploadBusinessLicense:
          uploadBusinessLicense ?? this.uploadBusinessLicense,
      businessTypeDesc: businessTypeDesc ?? this.businessTypeDesc,
      isChangeOnImage: isChangeOnImage ?? this.isChangeOnImage,
    );
  }
}
