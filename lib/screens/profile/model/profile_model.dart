import 'dart:convert';

ProfileResponseModel profileResponseModelFromJson(String str) =>
    ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) =>
    json.encode(data.toJson());

class ProfileResponseModel {
  String? status;
  String? message;
  ProfileData? data;

  ProfileResponseModel({
    this.status,
    this.message,
    this.data,
  });

  ProfileResponseModel copyWith({
    String? status,
    String? message,
    ProfileData? data,
  }) =>
      ProfileResponseModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileResponseModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class ProfileData {
  String? name;
  String? address1;
  String? address2;
  String? address3;
  String? postalCode;
  String? cityCode;
  String? cityDesc;
  String? stateCode;
  String? stateDesc;
  String? phoneNo;
  String? email;

  ProfileData({
    this.name,
    this.address1,
    this.address2,
    this.address3,
    this.postalCode,
    this.cityCode,
    this.cityDesc,
    this.stateCode,
    this.stateDesc,
    this.phoneNo,
    this.email,
  });

  ProfileData copyWith({
    String? name,
    String? address1,
    String? address2,
    String? address3,
    String? postalCode,
    String? cityCode,
    String? cityDesc,
    String? stateCode,
    String? stateDesc,
    String? phoneNo,
    String? email,
  }) =>
      ProfileData(
        name: name ?? this.name,
        address1: address1 ?? this.address1,
        address2: address2 ?? this.address2,
        address3: address3 ?? this.address3,
        postalCode: postalCode ?? this.postalCode,
        cityCode: cityCode ?? this.cityCode,
        cityDesc: cityDesc ?? this.cityDesc,
        stateCode: stateCode ?? this.stateCode,
        stateDesc: stateDesc ?? this.stateDesc,
        phoneNo: phoneNo ?? this.phoneNo,
        email: email ?? this.email,
      );

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        name: json["name"],
        address1: json["address1"],
        address2: json["address2"],
        address3: json["address3"],
        postalCode: json["postalCode"],
        cityCode: json["cityCode"],
        cityDesc: json["cityDesc"],
        stateCode: json["stateCode"],
        stateDesc: json["stateDesc"],
        phoneNo: json["phoneNo"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "postalCode": postalCode,
        "cityCode": cityCode,
        "cityDesc": cityDesc,
        "stateCode": stateCode,
        "stateDesc": stateDesc,
        "phoneNo": phoneNo,
        "email": email,
      };
}
