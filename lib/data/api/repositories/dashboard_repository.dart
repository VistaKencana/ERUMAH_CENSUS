import 'dart:convert';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/data/api/repositories/response_validator.dart';
import 'package:eperumahan_bancian/screens/dashboard/model/dashboard_json_model.dart';

class DashboardRepository {
  final client = ApiClient();

  Future<List<DashboardModel>> getLatest() async {
    final resp = await client.get(endpoint: "/appl/latest");
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));

    final model = DashboardJsonModel.fromJson(json).data ?? [];
    return model;
  }

  Future<List<DashboardModel>> getIncomplete() async {
    final resp = await client.get(endpoint: "/appl/incomplete");
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));

    final model = DashboardJsonModel.fromJson(json).data ?? [];
    return model;
  }
}
