import 'dart:convert';
import 'dart:isolate';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/area_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/block_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/floor_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/property_model.dart';

import 'model/zone_model.dart';
import 'response_validator.dart';

class PropertyRepository {
  final client = ApiClient();

  Future<List<ZoneData>> fetchZone() async {
    String baseUrl = client.baseUrl;
    final resp = await client.post(
      //remove  [/censusUser] from baseurl
      baseUrl: baseUrl.replaceAll("/censusUser", ""),
      endpoint: "/listZone",
    );
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final data = await Isolate.run(() => ZoneModel.fromJson(json));
    return data.data ?? [];
  }

  ///listHousingProject
  Future<List<AreaData>> fetchArea(
      {required String zoneCode,
      bool isGetAll = true,
      int? page,
      int? perPage}) async {
    final body = {"zoneCode": zoneCode};
    String baseUrl = client.baseUrl;
    String filter1 = page != null ? "?page=$page" : "";
    String filter2 = perPage != null ? "?perPage=$perPage" : "";
    String filter = (filter1.isNotEmpty && filter2.isNotEmpty)
        ? "$filter1&$filter2"
        : (filter1.isNotEmpty)
            ? filter1
            : filter2;
    //Get ALL
    filter = isGetAll ? "?perPage=all" : filter;
    final resp = await client.post(
      //remove  [/censusUser] from baseurl
      baseUrl: baseUrl.replaceAll("/censusUser", ""),
      endpoint: "/listHousingProject$filter",
      body: body,
    );
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final data = await Isolate.run(() => AreaModel.fromJson(json));
    return data.data ?? [];
  }

  Future<List<BlockData>> fetchBlock({required String housingCode}) async {
    final body = {"housingCode": housingCode};
    String baseUrl = client.baseUrl;
    final resp = await client.post(
      //remove  [/censusUser] from baseurl
      baseUrl: baseUrl.replaceAll("/censusUser", ""),
      endpoint: "/listUnitBlock",
      body: body,
    );
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final data = await Isolate.run(() => BlockModel.fromJson(json));
    return data.data ?? [];
  }

  Future<List<FloorData>> fetchUnitFloor(
      {required String housingCode, required String blockNo}) async {
    final body = {"housingCode": housingCode, "blockNo": blockNo};
    String baseUrl = client.baseUrl;
    final resp = await client.post(
      //remove  [/censusUser] from baseurl
      baseUrl: baseUrl.replaceAll("/censusUser", ""),
      endpoint: "/listUnitFloor",
      body: body,
    );
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final data = await Isolate.run(() => FloorModel.fromJson(json));
    return data.data ?? [];
  }

  Future<List<PropertyData>> fetchListProperties(
      {required String zoneCode,
      required String housingCode,
      required String blockNo,
      required String floor}) async {
    final body = {
      "zoneCode": zoneCode,
      "housingCode": housingCode,
      "block": blockNo,
      "floor": floor
    };

    final resp = await client.post(
      endpoint: "/appl/list?perPage=all",
      body: body,
    );
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final data = await Isolate.run(() => PropertyModel.fromJson(json));
    return data.data ?? [];
  }
}
