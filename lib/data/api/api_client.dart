import 'dart:convert';
import 'package:http/http.dart' as http;
import "dart:developer" as dev;

import '../hive-manager/repository/login_pref.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  String? _baseUrl;

  factory ApiClient() {
    return _instance;
  }
  static Future<void> init(String baseUrl) async {
    if (_instance._baseUrl == null) {
      _instance._baseUrl = baseUrl;
    } else {
      dev.log("Base URL has already been set!", name: "API Service");
    }
  }

  ApiClient._internal();

  // Base URL
  String get baseUrl => (_instance._baseUrl != null)
      ? _instance._baseUrl!
      : throw Exception("Please Initialize the Base URL in main.dart");

  // Common headers
  final Map<String, String> _commonHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Methods
  Future<http.Response> get(
      {String? baseUrl,
      required String endpoint,
      String? authToken,
      bool includeToken = true,
      Map<String, String>? headers}) async {
    final getToken = getAuthToken(includeToken);
    final token = includeToken ? (authToken ?? getToken) : null;
    final header = await _mergeHeaders(headers, token);
    final response = await http
        .get(Uri.parse((baseUrl ?? this.baseUrl) + endpoint), headers: header);
    return response;
  }

  Future<http.Response> post(
      {String? baseUrl,
      required String endpoint,
      dynamic body,
      String? authToken,
      bool includeToken = true,
      Map<String, String>? headers}) async {
    final getToken = getAuthToken(includeToken);
    final token = includeToken ? (authToken ?? getToken) : null;
    final header = await _mergeHeaders(headers, token);
    final response = await http.post(
        Uri.parse((baseUrl ?? this.baseUrl) + endpoint),
        headers: header,
        body: jsonEncode(body));
    return response;
  }

  Future<http.Response> put(
      {String? baseUrl,
      required String endpoint,
      dynamic body,
      bool includeToken = true,
      String? authToken,
      Map<String, String>? headers}) async {
    final getToken = getAuthToken(includeToken);
    final token = includeToken ? (authToken ?? getToken) : null;
    final header = await _mergeHeaders(headers, token);
    final response = await http.put(
        Uri.parse((baseUrl ?? this.baseUrl) + endpoint),
        headers: header,
        body: jsonEncode(body));
    return response;
  }

  Future<http.Response> delete(
      {String? baseUrl,
      required String endpoint,
      String? authToken,
      bool includeToken = true,
      Map<String, String>? headers}) async {
    final getToken = getAuthToken(includeToken);
    final token = includeToken ? (authToken ?? getToken) : null;
    final header = await _mergeHeaders(headers, token);
    final response = await http.delete(
        Uri.parse((baseUrl ?? this.baseUrl) + endpoint),
        headers: header);
    return response;
  }

  Future<http.Response> uploadFile(
      {String? baseUrl,
      required List<http.MultipartFile> files,
      required String endpoint,
      String? authToken,
      bool includeToken = true,
      Map<String, String>? body,
      Map<String, String>? headers}) async {
    final getToken = getAuthToken(includeToken);
    final token = includeToken ? (authToken ?? getToken) : null;
    final header = await _mergeHeaders(headers, token);

    var url = Uri.parse("${baseUrl ?? this.baseUrl}$endpoint");
    final request = http.MultipartRequest('POST', url);
    request.headers.addAll(header);
    if (body != null) {
      request.fields.addAll(body);
    }
    for (var file in files) {
      request.files.add(file);
    }

    final response = await http.Response.fromStream(await request.send());
    return response;
  }

  Future<Map<String, String>> _mergeHeaders(
      Map<String, String>? headers, String? authToken) async {
    final mergedHeaders = Map<String, String>.from(_commonHeaders);
    if (headers != null) {
      mergedHeaders.addAll(headers);
    }
    if (authToken != null) {
      mergedHeaders.addAll({'Authorization': 'Bearer $authToken'});
    }
    return mergedHeaders;
  }

  //GET TOKEN FROM PREFERENCE
  String? getAuthToken(bool includToken) {
    if (!includToken) return null;
    final isExist = LoginPreference().isTokenExist();
    if (!isExist) return null;
    final token = LoginPreference().isTokenExpired();
    if (token == null) throw TokenExpiredException();
    return token;
  }
}

//Custom Exception
class TokenExpiredException implements Exception {
  final String message;

  TokenExpiredException([this.message = 'Token has expired']);

  @override
  String toString() => 'TokenExpiredException: $message';
}
