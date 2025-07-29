import 'dart:convert';

PropertyModel propertyModelFromJson(String str) =>
    PropertyModel.fromJson(json.decode(str));

String propertyModelToJson(PropertyModel data) => json.encode(data.toJson());

class PropertyModel {
  String? status;
  String? message;
  List<PropertyData>? data;
  PropertyPagination? pagination;

  PropertyModel({
    this.status,
    this.message,
    this.data,
    this.pagination,
  });

  PropertyModel copyWith({
    String? status,
    String? message,
    List<PropertyData>? data,
    PropertyPagination? pagination,
  }) =>
      PropertyModel(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        pagination: pagination ?? this.pagination,
      );

  factory PropertyModel.fromJson(Map<String, dynamic> json) => PropertyModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<PropertyData>.from(
                json["data"]!.map((x) => PropertyData.fromJson(x))),
        pagination: json["pagination"] == null ||
                (json["pagination"] is Map && json["pagination"].isEmpty)
            ? null
            : PropertyPagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class PropertyData {
  String? zoneCode;
  String? zoneDesc;
  String? housingCode;
  String? housingDesc;
  String? unitCode;
  String? unitBlock;
  String? unitFloor;
  String? unitNo;
  String? status;
  int? totalVisit;
  List<Visit>? visit;

  PropertyData({
    this.zoneCode,
    this.zoneDesc,
    this.housingCode,
    this.housingDesc,
    this.unitCode,
    this.unitBlock,
    this.unitFloor,
    this.unitNo,
    this.status,
    this.totalVisit,
    this.visit,
  });

  PropertyData copyWith({
    String? zoneCode,
    String? zoneDesc,
    String? housingCode,
    String? housingDesc,
    String? unitCode,
    String? unitBlock,
    String? unitFloor,
    String? unitNo,
    String? status,
    int? totalVisit,
    List<Visit>? visit,
  }) =>
      PropertyData(
        zoneCode: zoneCode ?? this.zoneCode,
        zoneDesc: zoneDesc ?? this.zoneDesc,
        housingCode: housingCode ?? this.housingCode,
        housingDesc: housingDesc ?? this.housingDesc,
        unitCode: unitCode ?? this.unitCode,
        unitBlock: unitBlock ?? this.unitBlock,
        unitFloor: unitFloor ?? this.unitFloor,
        unitNo: unitNo ?? this.unitNo,
        status: status ?? this.status,
        totalVisit: totalVisit ?? this.totalVisit,
        visit: visit ?? this.visit,
      );

  factory PropertyData.fromJson(Map<String, dynamic> json) => PropertyData(
        zoneCode: json["zoneCode"]!,
        zoneDesc: json["zoneDesc"]!,
        housingCode: json["housingCode"]!,
        housingDesc: json["housingDesc"]!,
        unitCode: json["unitCode"],
        unitBlock: json["unitBlock"],
        unitFloor: json["unitFloor"],
        unitNo: json["unitNo"],
        status: json["status"]!,
        totalVisit: json["totalVisit"],
        visit: json["Visit"] == null
            ? []
            : List<Visit>.from(json["Visit"]!.map((x) => Visit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "zoneCode": zoneCode,
        "zoneDesc": zoneDesc,
        "housingCode": housingCode,
        "housingDesc": housingDesc,
        "unitCode": unitCode,
        "unitBlock": unitBlock,
        "unitFloor": unitFloor,
        "unitNo": unitNo,
        "status": status,
        "totalVisit": totalVisit,
        "Visit": visit == null
            ? []
            : List<dynamic>.from(visit!.map((x) => x.toJson())),
      };

  String getStatusName() {
    final isBelum = (status?.toLowerCase().contains("belum") ?? false);
    return isBelum ? "BELUM MULA" : "-";
  }
}

class Visit {
  String? status;
  String? remark;
  String? round;

  Visit({
    this.status,
    this.remark,
    this.round,
  });

  Visit copyWith({
    String? status,
    String? remark,
    String? round,
  }) =>
      Visit(
        status: status ?? this.status,
        remark: remark ?? this.remark,
        round: round ?? this.round,
      );

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
        status: json["status"],
        remark: json["remark"],
        round: json["round"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "remark": remark,
        "round": round,
      };
}

class PropertyPagination {
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

  PropertyPagination({
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

  PropertyPagination copyWith({
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
      PropertyPagination(
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

  factory PropertyPagination.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      // Return a default instance if the JSON is empty
      return PropertyPagination();
    }

    return PropertyPagination(
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
