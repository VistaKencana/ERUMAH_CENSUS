import 'dart:convert';

BlockModel blockModelFromJson(String str) =>
    BlockModel.fromJson(json.decode(str));

String blockModelToJson(BlockModel data) => json.encode(data.toJson());

class BlockModel {
  String? status;
  List<BlockData>? data;

  BlockModel({
    this.status,
    this.data,
  });

  BlockModel copyWith({
    String? status,
    List<BlockData>? data,
  }) =>
      BlockModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<BlockData>.from(
                json["data"]!.map((x) => BlockData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BlockData {
  String? blockNo;

  BlockData({
    this.blockNo,
  });

  BlockData copyWith({
    String? blockNo,
  }) =>
      BlockData(
        blockNo: blockNo ?? this.blockNo,
      );

  factory BlockData.fromJson(Map<String, dynamic> json) => BlockData(
        blockNo: json["blockNo"],
      );

  Map<String, dynamic> toJson() => {
        "blockNo": blockNo,
      };
}
