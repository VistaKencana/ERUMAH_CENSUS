import 'dart:typed_data';

import 'package:screenshot/screenshot.dart';

class ScreenshotHelper {
  static Future<Uint8List?> capture(
    ScreenshotController controller, {
    void Function()? onCapture,
    void Function()? onComplete,
  }) async {
    try {
      if (onCapture != null) onCapture();
      final result =
          await controller.capture(delay: const Duration(milliseconds: 10));
      if (onComplete != null) onComplete();
      return result;
    } catch (e) {
      return null;
    }
  }
}
