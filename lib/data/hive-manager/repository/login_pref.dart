import 'dart:convert';
import 'dart:developer' as dev;

import 'package:eperumahan_bancian/screens/login/model/login_model.dart';

import '../hive_manager.dart';

class LoginPreference {
  static final loginPref = HiveBoxPreference<String>(key: "loginData");
  Future<void> saveData({required LoginModel model}) async {
    dev.log("Save to preference", name: "Login");
    await loginPref.saveData(value: jsonEncode(model.toJson()));
  }

  Future<String?> isTokenExpired() async {
    if (!(await isTokenExist())) return null;
    final data = loginPref.getData();
    final resp = LoginModel.fromJson(jsonDecode(data!)).data!;
    DateTime now = DateTime.now();
    DateTime? expiryDate = resp.expiresAt;
    if (expiryDate == null) return null;
    return (now.isBefore(expiryDate)) ? resp.accessToken : null;
  }

  String? getUserId() {
    final data = loginPref.getData();
    if (data == null) return null;
    final loginData = LoginModel.fromJson(jsonDecode(data));
    return loginData.data?.userCode;
  }

  String? getUsername() {
    final data = loginPref.getData();
    if (data == null) return null;
    final loginData = LoginModel.fromJson(jsonDecode(data));
    return loginData.data?.userName;
  }

  Future<bool> isTokenExist() async => loginPref.getData() != null;

  static Future<void> clearData() async => await loginPref.deleteData();
}
