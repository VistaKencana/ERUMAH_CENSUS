import 'dart:typed_data';

class StatusInputModel {
  String censusCode;
  String isFingerPrintVerified;
  String statusCode;
  String email;
  String remark;
  List<Uint8List> images;

  StatusInputModel({
    required this.censusCode,
    required this.isFingerPrintVerified,
    required this.statusCode,
    required this.email,
    required this.remark,
    this.images = const [],
  });

  // CopyWith method
  StatusInputModel copyWith({
    String? censusCode,
    String? isFingerPrintVerified,
    String? statusCode,
    String? email,
    String? remark,
    List<Uint8List>? images,
  }) {
    return StatusInputModel(
      censusCode: censusCode ?? this.censusCode,
      isFingerPrintVerified:
          isFingerPrintVerified ?? this.isFingerPrintVerified,
      statusCode: statusCode ?? this.statusCode,
      email: email ?? this.email,
      remark: remark ?? this.remark,
      images: images ?? this.images,
    );
  }

  // toJson method
  Map<String, String> toJson() {
    return {
      'censusCode': censusCode,
      'isFingerPrintVerified': isFingerPrintVerified,
      'statusCode': statusCode,
      'email': email,
      'remark': remark,
    };
  }

  List<Uint8List> getFiles() {
    return images;
  }

  // fromJson method
  factory StatusInputModel.fromJson(Map<String, dynamic> json) {
    return StatusInputModel(
      censusCode: json['censusCode'] as String,
      isFingerPrintVerified: json['isFingerPrintVerified'] as String,
      statusCode: json['statusCode'] as String,
      email: json['email'] as String,
      remark: json['remark'] as String,
    );
  }
}
