import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingConfig {
  static Future<void> init() async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = false
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.black;
  }
}
