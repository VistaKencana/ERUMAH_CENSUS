import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  // Private constructor
  // ApiClient._();
  // ApiClient._(this.baseUrl);
  // Singleton instance variable
  // static ApiClient? _instance;
  // Static method to access the singleton instance
  // static ApiClient getInstance({required String baseUrl}) {
  //   _instance ??= ApiClient._(baseUrl);
  //   return _instance!;
  // }
  static final ApiClient _instance = ApiClient._internal();

  factory ApiClient() {
    return _instance;
  }

  ApiClient._internal();

  // Base URL
  String baseUrl = "https://capitalpark.fastsystem.com.my";

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
    final getToken = getAuthToken();
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
    final getToken = getAuthToken();
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
    final getToken = getAuthToken();
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
    final getToken = getAuthToken();
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
      Map<String, String>? body}) async {
    var url = Uri.parse("${baseUrl ?? this.baseUrl}$endpoint");
    final request = http.MultipartRequest('POST', url);
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
  String? getAuthToken() {
    // final isExist = LoginPreference().isTokenExist();
    // if (!isExist) return null;
    // final token = LoginPreference().isTokenExpired();
    // if (token == null) throw TokenExpiredException();
    // return token;
    return null;
  }
}

//Custom Exception
class TokenExpiredException implements Exception {
  final String message;

  TokenExpiredException([this.message = 'Token has expired']);

  @override
  String toString() => 'TokenExpiredException: $message';
}
