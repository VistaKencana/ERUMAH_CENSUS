import 'dart:convert';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/screens/login/model/login_model.dart';
import 'package:eperumahan_bancian/services/mobile_info.dart';

import 'response_validator.dart';

class AuthRepository {
  final client = ApiClient();

  Future<LoginModel> userLogin(
      {required String userCode, required String password}) async {
    final body = {
      "userCode": userCode,
      "password": password,
      "pushID": "e7431349-4582-46f2-ac1e-8fce904d6bf8",
      "deviceInfo": MobileInfo.deviceModel,
      "platform": MobileInfo.deviceOS
    };
    final resp =
        await client.post(endpoint: "/login", body: body, includeToken: false);
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final model = LoginModel.fromJson(json);
    return model;
  }

  Future<bool> userLogout() async {
    final resp = await client.post(endpoint: "/logout");
    final json = jsonDecode(resp.body);
    return RespValidator.isSuccess(json);
  }
}
