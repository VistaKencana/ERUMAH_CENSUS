import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EasyLoadingConfig {
  static Future<void> init() async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..progressColor = const Color(0xFF8D182D)
      ..backgroundColor = Colors.white
      ..indicatorColor = const Color(0xFF8D182D)
      ..textColor = const Color(0xFF8D182D)
      ..maskColor = Colors.black.withValues(alpha: 0.1)
      ..indicatorSize = 45.0
      ..radius = 100.0
      ..userInteractions = false
      ..dismissOnTap = false
      ..maskType = EasyLoadingMaskType.black;
  }
}
