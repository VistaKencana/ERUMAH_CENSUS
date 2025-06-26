import 'dart:math';
import 'package:flutter/material.dart';

enum BrightnessStyle { light, dark, vibrant }

extension PurpleColorGenerator on int {
  Color toPurpleColor({BrightnessStyle style = BrightnessStyle.dark}) {
    final random = Random(this); // seed based on int (e.g., index)

    switch (style) {
      case BrightnessStyle.light:
        // HSL: brighter, softer purple
        double hue = 270 + random.nextDouble() * 20 - 10; // Around purple
        double lightness = 0.7 + random.nextDouble() * 0.2; // 0.7 - 0.9
        return HSLColor.fromAHSL(1.0, hue, 0.6, lightness).toColor();

      case BrightnessStyle.dark:
        double hue = 270 + random.nextDouble() * 20 - 10;
        double lightness = 0.3 + random.nextDouble() * 0.2; // 0.3 - 0.5
        return HSLColor.fromAHSL(1.0, hue, 0.6, lightness).toColor();

      case BrightnessStyle.vibrant:
        // RGB: strong purple with randomization
        int red = 128 + random.nextInt(127);
        int green = random.nextInt(40); // low green = more saturation
        int blue = 128 + random.nextInt(127);
        return Color.fromARGB(255, red, green, blue);
    }
  }
}

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      _floatToInt8(a),
      (_floatToInt8(r) * value).round(),
      (_floatToInt8(g) * value).round(),
      (_floatToInt8(b) * value).round(),
    );
  }

  // Int color components were deprecated in Flutter 3.27.0.
  // This method is used to convert the new double color components to the
  // old int color components.
  //
  // Taken from the Color class.
  int _floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }
}
