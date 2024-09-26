import 'dart:convert';
import 'dart:isolate';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/dropdown_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/response_validator.dart';
import 'dart:developer' as dev;

class DropdownRepository {
  final client = ApiClient();

  Future<List<DropdownData>> getDropdownData({required DdType type}) async {
    dev.log(name: "DROPDOWN REPO", "Fetch dropdown for : ${type.name}");

    String baseUrl = client.baseUrl;
    final resp = await client.get(
      baseUrl: baseUrl.replaceAll("/censusUser", ""),
      endpoint: type.endpoint,
    );
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final model = await Isolate.run(() => DropdownModel.fromJson(json));
    return model.data ?? [];
  }
}

enum DdType {
  gender(endpoint: "/listGender"),
  race(endpoint: "/listRace"),
  maritalStatus(endpoint: "/listMaritalStatus"),
  occupationType(endpoint: "/listOccupationType"),
  relationship(endpoint: "/listRelationship"),
  healthLevel(endpoint: "/listHealthLevel"),
  censusStatus(endpoint: "/censusUser/appl/listStatus");

  final String endpoint;

  const DdType({required this.endpoint});
}
