import 'dart:convert';

FloorModel floorModelFromJson(String str) =>
    FloorModel.fromJson(json.decode(str));

String floorModelToJson(FloorModel data) => json.encode(data.toJson());

class FloorModel {
  String? status;
  List<FloorData>? data;

  FloorModel({
    this.status,
    this.data,
  });

  FloorModel copyWith({
    String? status,
    List<FloorData>? data,
  }) =>
      FloorModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory FloorModel.fromJson(Map<String, dynamic> json) => FloorModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<FloorData>.from(
                json["data"]!.map((x) => FloorData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class FloorData {
  String? floorNo;

  FloorData({
    this.floorNo,
  });

  FloorData copyWith({
    String? floorNo,
  }) =>
      FloorData(
        floorNo: floorNo ?? this.floorNo,
      );

  factory FloorData.fromJson(Map<String, dynamic> json) => FloorData(
        floorNo: json["floorNo"],
      );

  Map<String, dynamic> toJson() => {
        "floorNo": floorNo,
      };
}
