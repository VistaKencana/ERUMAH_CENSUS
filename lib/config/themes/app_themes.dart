import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppThemes {
  //ADD LIGHT THEME
  static final lightTheme = ThemeData(
      useMaterial3: true,
      progressIndicatorTheme: const ProgressIndicatorThemeData()
          .copyWith(color: AppColors.primary.color),
      appBarTheme: AppBarTheme(color: AppColors.primary.color),
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.darkGrey.color),
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme().copyWith(
        fillColor: AppColors.lightGrey.color,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        filled: true,
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.lightGrey.color)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black, width: 2)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 2)),
      ),
      tabBarTheme: TabBarTheme(
          labelColor: AppColors.primary.color,
          labelStyle: TextStyle(color: AppColors.primary.color),
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: AppColors.primary.color),
          )),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.white)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary.color,
            shadowColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
      ));
  //ADD DARK THEME
  static final darkTheme = ThemeData(useMaterial3: true);
}
