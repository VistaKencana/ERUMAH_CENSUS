import 'dart:convert';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/screens/profile/model/profile_model.dart';

import 'response_validator.dart';

class ProfileRepository {
  final client = ApiClient();

  Future<ProfileResponseModel> getUserProfile() async {
    final resp = await client.get(endpoint: "/viewProfile");
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final model = ProfileResponseModel.fromJson(json);
    return model;
  }
}
