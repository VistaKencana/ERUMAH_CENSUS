import 'package:flutter/material.dart';

enum AppColors {
  darkGrey(color: Color(0xFF383838)),
  midGrey(color: Color(0xFFEEEDED)),
  lightGrey(color: Color(0xFFF5F5F5)),
  primary(color: Color(0xFF312D81)),
  ;

  final Color color;

  const AppColors({required this.color});
}
