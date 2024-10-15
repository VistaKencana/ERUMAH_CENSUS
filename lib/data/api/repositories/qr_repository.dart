import 'dart:convert';
import 'dart:isolate';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/screens/qr-home/models/resident_info_model.dart';
import 'response_validator.dart';

enum Searchtype { qrCode, unitCode }

class QrRepository {
  final client = ApiClient();

  Future<ResidentInfoData> scanQrCode(
      {Searchtype type = Searchtype.qrCode, required String code}) async {
    final body = {"type": type.name, "code": code};
    final resp = await client.post(endpoint: "/appl/view", body: body);
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final data = await Isolate.run(() => ResidentInfoModel.fromJson(json));
    return data.data!;
  }

  Future<bool> registerQrCode(
      {required String qrCode, required String unitCode}) async {
    final body = {"qrCode": qrCode, "unitCode": unitCode};
    final resp =
        await client.post(endpoint: "/appl/registerQrCode", body: body);
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(isQrRegisterErrorValid(json));
    return isValid;
  }

  Future<bool> updateQrCode(
      {required String qrCode, required String unitCode}) async {
    final body = {"qrCode": qrCode, "unitCode": unitCode};
    final resp = await client.post(endpoint: "/appl/updateQrCode", body: body);
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(json);
    return isValid;
  }

  String isQrRegisterErrorValid(dynamic json) {
    try {
      final type = json["type"].toString();
      final map = {
        "qrCodeRegistered": "A",
        "otherQrCodeRegistered": "B",
        "duplicateQrCode": "C"
      };
      var result = map[type];
      return "${result != null} $type";
    } catch (e) {
      return "false";
    }
  }
}
