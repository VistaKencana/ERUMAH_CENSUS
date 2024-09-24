import 'dart:convert';
import 'dart:isolate';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/dropdown_model.dart';
import 'package:eperumahan_bancian/data/api/repositories/response_validator.dart';
import 'dart:developer' as dev;

class DropdownRepository {
  final client = ApiClient();

  Future<List<DropdownData?>> getDropdownData(
      {DdType type = DdType.all}) async {
    dev.log(name: "DROPDOWN REPO", "Fetch dropdown for : ${type.name}");

    final filter = type == DdType.all ? "" : "?list=${type.name}";
    String baseUrl = client.baseUrl;
    final resp = await client.get(
      baseUrl: baseUrl.replaceAll("/censusUser", ""),
      endpoint: "/dropdown/list$filter",
    );
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final model = await Isolate.run(() => DropdownModel.fromJson(json));
    return model.data!.dynamicData?[type.name] ?? [];
  }
}

enum DdType {
  all,
  zone,
  parliament,
  race,
  gender,
  maritalStatus,
  occupationType,
  censusStatus,
  relationship,
  healthLevel
}
