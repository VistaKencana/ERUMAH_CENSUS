import 'dart:convert';

DashboardActivityJsonModel dashboardActivityJsonModelFromJson(String str) =>
    DashboardActivityJsonModel.fromJson(json.decode(str));

String dashboardActivityJsonModelToJson(DashboardActivityJsonModel data) =>
    json.encode(data.toJson());

class DashboardActivityJsonModel {
  String? status;
  String? message;
  DashboardUserActivity? data;

  DashboardActivityJsonModel({
    this.status,
    this.message,
    this.data,
  });

  DashboardActivityJsonModel copyWith({
    String? status,
    String? message,
    DashboardUserActivity? data,
  }) =>
      DashboardActivityJsonModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DashboardActivityJsonModel.fromJson(Map<String, dynamic> json) =>
      DashboardActivityJsonModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : DashboardUserActivity.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class DashboardUserActivity {
  String? totalUnit;
  String? totalInProgress;
  String? totalComplete;
  String? totalIncomplete;

  DashboardUserActivity({
    this.totalUnit,
    this.totalInProgress,
    this.totalComplete,
    this.totalIncomplete,
  });

  DashboardUserActivity copyWith({
    String? totalUnit,
    String? totalInProgress,
    String? totalComplete,
    String? totalIncomplete,
  }) =>
      DashboardUserActivity(
        totalUnit: totalUnit ?? this.totalUnit,
        totalInProgress: totalInProgress ?? this.totalInProgress,
        totalComplete: totalComplete ?? this.totalComplete,
        totalIncomplete: totalIncomplete ?? this.totalIncomplete,
      );

  factory DashboardUserActivity.fromJson(Map<String, dynamic> json) =>
      DashboardUserActivity(
        totalUnit: json["totalUnit"],
        totalInProgress: json["totalInProgress"],
        totalComplete: json["totalComplete"],
        totalIncomplete: json["totalIncomplete"],
      );

  Map<String, dynamic> toJson() => {
        "totalUnit": totalUnit,
        "totalInProgress": totalInProgress,
        "totalComplete": totalComplete,
        "totalIncomplete": totalIncomplete,
      };
}
