import 'dart:convert';

import 'package:eperumahan_bancian/data/api/api_client.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/dependant_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/owner_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/spouse_input_model.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/models/status_input_model.dart';
import 'package:http/http.dart' as http;

import 'response_validator.dart';

class ApplicationRepository {
  final client = ApiClient();

  Future<String> getCensusCode({required String qrcCode}) async {
    final body = {"qrCode": qrcCode};
    final resp = await client.post(endpoint: "/appl/store", body: body);
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    return json["data"]["censusCode"];
  }

  Future<String> storeOwner({required OwnerInputModel data}) async {
    //Set isNotOwner = false; 0-false , 1-true
    data = data.copyWith(isNotOwner: "0");
    List<http.MultipartFile> files = [];
    int cnt = 0;
    for (var entry in data.getFiles().entries) {
      final field = entry.key;
      final img = entry.value;
      if (img != null) {
        cnt++;
        files.add(client.bytesToMultipartFile(
            fieldName: field, bytes: img, filename: "image_$cnt.jpg"));
      }
    }

    final resp = await client.postFormData(
        endpoint: "/appl/owner/store", files: files, body: data.toJson());
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    return json.toString();
  }

  Future<String> storeNotOwner({required OwnerInputModel data}) async {
    //Set isNotOwner = true; 0-false , 1-true
    data = data.copyWith(isNotOwner: "1");
    List<http.MultipartFile> files = [];
    int cnt = 0;
    for (var entry in data.getFiles().entries) {
      final field = entry.key;
      final img = entry.value;
      if (img != null) {
        cnt++;
        files.add(client.bytesToMultipartFile(
            fieldName: field, bytes: img, filename: "image_$cnt.jpg"));
      }
    }
    final resp = await client.postFormData(
        endpoint: "/appl/owner/store", files: files, body: data.toJson());
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    return json.toString();
  }

  Future<String> storeSpouse({required SpouseInputModel data}) async {
    List<http.MultipartFile> files = [];
    int cnt = 0;
    for (var entry in data.getFiles().entries) {
      final field = entry.key;
      final img = entry.value;
      if (img != null) {
        cnt++;
        files.add(client.bytesToMultipartFile(
            fieldName: field, bytes: img, filename: "image_$cnt.jpg"));
      }
    }

    final resp = await client.postFormData(
        endpoint: "/appl/spouse/store", files: files, body: data.toJson());
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    return json.toString();
  }

  Future<String> storeDependant({required DependantInputModel data}) async {
    List<http.MultipartFile> files = [];
    int cnt = 0;
    for (var entry in data.getFiles().entries) {
      final field = entry.key;
      final img = entry.value;
      if (img != null) {
        cnt++;
        files.add(client.bytesToMultipartFile(
            fieldName: field, bytes: img, filename: "image_$cnt.jpg"));
      }
    }
    final resp = await client.postFormData(
        endpoint: "/appl/dependant/store", files: files, body: data.toJson());
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    return json.toString();
  }

  Future<String> storeStatus({required StatusInputModel data}) async {
    List<http.MultipartFile> files = [];
    int cnt = 0;
    for (var img in data.getFiles()) {
      cnt++;
      files.add(client.bytesToMultipartFile(
          fieldName: "images[]", bytes: img, filename: "image_$cnt.jpg"));
    }
    final resp = await client.postFormData(
        endpoint: "/appl/status/update", files: files, body: data.toJson());
    final json = jsonDecode(resp.body);
    final isValid = RespValidator.isSuccess(json);
    if (!isValid) throw Exception(RespValidator.getMessage(json));
    return json.toString();
  }
}
