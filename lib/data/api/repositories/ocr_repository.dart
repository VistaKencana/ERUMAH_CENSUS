import 'dart:convert';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/data/api/repositories/model/ocr_json_response_mode.dart';
import 'package:eperumahan_bancian/data/api/repositories/response_validator.dart';
import 'package:http/http.dart' as http;

class OcrRepository {
  final client = ApiClient();

  Future<OcrDataModel> scanMyKad({required Uint8List frontIc}) async {
    List<http.MultipartFile> files = [];
    files.add(client.bytesToMultipartFile(
        fieldName: "image", bytes: frontIc, filename: "image_0.jpg"));

    final resp = await client.postFormData(endpoint: "/appl/ocr", files: files);

    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    final data = await Isolate.run(() => OcrJsonResponseModel.fromJson(json));
    return data.data ?? OcrDataModel();
  }
}
