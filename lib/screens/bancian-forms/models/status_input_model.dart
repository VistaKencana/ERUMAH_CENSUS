import 'dart:typed_data';

class StatusInputModel {
  String censusCode;
  String isFingerPrintVerified;
  String? statusCode;

  String remark;
  List<Uint8List> images;

  StatusInputModel({
    required this.censusCode,
    this.isFingerPrintVerified = "0",
    this.statusCode,
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
      remark: remark ?? this.remark,
      images: images ?? this.images,
    );
  }

  // toJson method
  Map<String, String> toJson() {
    return {
      'censusCode': censusCode,
      'isFingerPrintVerified': isFingerPrintVerified,
      // 'statusCode': statusCode ?? "",
      'remark': remark,
    };
  }

  List<Uint8List> getFiles() {
    return images;
  }

  void addImages(Uint8List img) {
    images.add(img);
  }

  void removeImages(int index) {
    images.removeAt(index);
  }

  // fromJson method
  factory StatusInputModel.fromJson(Map<String, dynamic> json) {
    return StatusInputModel(
      censusCode: json['censusCode'] as String,
      isFingerPrintVerified: json['isFingerPrintVerified'] as String,
      statusCode: json['statusCode'] as String,
      remark: json['remark'] as String,
    );
  }
}
