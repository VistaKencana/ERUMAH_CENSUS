import 'dart:convert';

AreaModel areaModelFromJson(String str) => AreaModel.fromJson(json.decode(str));

String areaModelToJson(AreaModel data) => json.encode(data.toJson());

class AreaModel {
  String? status;
  String? message;
  List<AreaData>? data;
  AreaPagination? pagination;

  AreaModel({
    this.status,
    this.message,
    this.data,
    this.pagination,
  });

  AreaModel copyWith({
    String? status,
    String? message,
    List<AreaData>? data,
    AreaPagination? pagination,
  }) =>
      AreaModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        pagination: pagination ?? this.pagination,
      );

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AreaData>.from(
                json["data"]!.map((x) => AreaData.fromJson(x))),
        pagination: json["pagination"] == null ||
                (json["pagination"] is Map && json["pagination"].isEmpty)
            ? null
            : AreaPagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination,
      };
}

class AreaData {
  String? code;
  String? desc;
  AreaParliament? parliament;
  AreaZone? zone;

  AreaData({
    this.code,
    this.desc,
    this.parliament,
    this.zone,
  });

  AreaData copyWith({
    String? code,
    String? desc,
    AreaParliament? parliament,
    AreaZone? zone,
  }) =>
      AreaData(
        code: code ?? this.code,
        desc: desc ?? this.desc,
        parliament: parliament ?? this.parliament,
        zone: zone ?? this.zone,
      );

  factory AreaData.fromJson(Map<String, dynamic> json) => AreaData(
        code: json["code"],
        desc: json["desc"],
        parliament: json["parliament"] == null
            ? null
            : AreaParliament.fromJson(json["parliament"]),
        zone: json["zone"] == null ? null : AreaZone.fromJson(json["zone"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
        "parliament": parliament?.toJson(),
        "zone": zone?.toJson(),
      };
}

class AreaParliament {
  String? code;
  String? desc;

  AreaParliament({
    this.code,
    this.desc,
  });

  AreaParliament copyWith({
    String? code,
    String? desc,
  }) =>
      AreaParliament(
        code: code ?? this.code,
        desc: desc ?? this.desc,
      );

  factory AreaParliament.fromJson(Map<String, dynamic> json) => AreaParliament(
        code: json["code"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
      };
}

class AreaZone {
  String? code;
  String? desc;

  AreaZone({
    this.code,
    this.desc,
  });

  AreaZone copyWith({
    String? code,
    String? desc,
  }) =>
      AreaZone(
        code: code ?? this.code,
        desc: desc ?? this.desc,
      );

  factory AreaZone.fromJson(Map<String, dynamic> json) => AreaZone(
        code: json["code"],
        desc: json["desc"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "desc": desc,
      };
}

class AreaPagination {
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  AreaPagination({
    this.currentPage,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  AreaPagination copyWith({
    int? currentPage,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    String? nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) =>
      AreaPagination(
        currentPage: currentPage ?? this.currentPage,
        firstPageUrl: firstPageUrl ?? this.firstPageUrl,
        from: from ?? this.from,
        lastPage: lastPage ?? this.lastPage,
        lastPageUrl: lastPageUrl ?? this.lastPageUrl,
        nextPageUrl: nextPageUrl ?? this.nextPageUrl,
        path: path ?? this.path,
        perPage: perPage ?? this.perPage,
        prevPageUrl: prevPageUrl ?? this.prevPageUrl,
        to: to ?? this.to,
        total: total ?? this.total,
      );

  factory AreaPagination.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      // Return a default instance if the JSON is empty
      return AreaPagination();
    }

    return AreaPagination(
      currentPage: json["CurrentPage"],
      firstPageUrl: json["FirstPageUrl"],
      from: json["From"],
      lastPage: json["LastPage"],
      lastPageUrl: json["LastPageUrl"],
      nextPageUrl: json["NextPageUrl"],
      path: json["Path"],
      perPage: json["PerPage"],
      prevPageUrl: json["PrevPageUrl"],
      to: json["To"],
      total: json["Total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "CurrentPage": currentPage,
        "FirstPageUrl": firstPageUrl,
        "From": from,
        "LastPage": lastPage,
        "LastPageUrl": lastPageUrl,
        "NextPageUrl": nextPageUrl,
        "Path": path,
        "PerPage": perPage,
        "PrevPageUrl": prevPageUrl,
        "To": to,
        "Total": total,
      };
}
