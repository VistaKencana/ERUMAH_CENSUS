class RespValidator {
  static bool isSuccess(dynamic json) {
    return json["status"].toString().toLowerCase() == 'success';
  }

  static String getMessage(dynamic json) {
    final msg = json["message"].toString();
    return msg;
  }
}
