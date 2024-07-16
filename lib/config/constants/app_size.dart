import 'package:flutter/material.dart';

class AppSize {
  //Singleton Pattern
  AppSize._privateConstructor();
  static final AppSize _instance = AppSize._privateConstructor();
  factory AppSize() => _instance;

  // Add your methods and properties here
  double? screenWidth;
  double? screenHeight;
  BuildContext? context;

  // Initialize method to set screen dimensions and context
  void initialize(BuildContext context) {
    this.context = context;
    final size = MediaQuery.sizeOf(context);
    screenWidth = size.width;
    screenHeight = size.height;
  }

  double getGridAspectRatio() {
    final isMobile = screenWidth! < 400;
    const mRatio = 16 / 8;
    return isMobile ? mRatio : 16 / 4.2;
  }
}
