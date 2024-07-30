class LoginModel {
  String? status;
  String? message;
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  LoginModel copyWith({
    String? status,
    String? message,
    Data? data,
  }) =>
      LoginModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? accessToken;
  String? tokenType;
  DateTime? expiresAt;
  String? userCode;
  String? userName;

  Data({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
    this.userCode,
    this.userName,
  });

  Data copyWith({
    String? accessToken,
    String? tokenType,
    DateTime? expiresAt,
    String? userCode,
    String? userName,
  }) =>
      Data(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresAt: expiresAt ?? this.expiresAt,
        userCode: userCode ?? this.userCode,
        userName: userName ?? this.userName,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresAt: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
        userCode: json["userCode"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_at": expiresAt?.toIso8601String(),
        "userCode": userCode,
        "userName": userName,
      };
}
