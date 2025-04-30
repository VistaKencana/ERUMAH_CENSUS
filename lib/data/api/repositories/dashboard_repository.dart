import 'dart:convert';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/data/api/repositories/response_validator.dart';
import 'package:eperumahan_bancian/screens/dashboard/model/dashboard_activity_json_model.dart';
import 'package:eperumahan_bancian/screens/dashboard/model/dashboard_json_model.dart';

import '../../hive-manager/repository/login_pref.dart';

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

  Future<DashboardUserActivity> getUserActivity(
      {String? month, String? year}) async {
    final loginPref = LoginPreference();
    String userId = loginPref.getUserId()!;
    DateTime now = DateTime.now();
    String inputMonth = month ?? now.month.toString();
    String inputYear = year ?? now.year.toString();
    String endpoint = "/activity/$userId?month=$inputMonth&year=$inputYear";
    final resp = await client.get(endpoint: endpoint);
    final json = jsonDecode(resp.body);

    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));

    final model = DashboardActivityJsonModel.fromJson(json).data!;
    return model;
  }
}
