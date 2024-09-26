import 'dart:convert';
import 'dart:isolate';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/screens/qr-home/models/resident_info_model.dart';

import 'response_validator.dart';

class QrRepository {
  final client = ApiClient();

  Future<ResidentInfoData> scanQrCode({required String qrCode}) async {
    final body = {"qrCode": qrCode};
    final resp = await client.post(endpoint: "/appl/view", body: body);
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final data = await Isolate.run(() => ResidentInfoModel.fromJson(json));
    return data.data!;
  }

  Future<String> registerQrCode(
      {required String qrCode, required String unitCode}) async {
    final body = {"qrCode": qrCode, "unitCode": unitCode};
    final resp =
        await client.post(endpoint: "/appl/registerQrCode", body: body);
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    return resp.body;
  }

  Future<void> updateQrCode(
      {required String qrCode, required String unitCode}) async {
    final body = {"qrCode": qrCode, "unitCode": unitCode};
    final resp = await client.post(endpoint: "/appl/updateQrCode", body: body);
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
  }
}
