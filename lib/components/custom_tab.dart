import 'package:flutter/material.dart';

import '../config/constants/app_colors.dart';

class CustomTab extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CustomTab({super.key, required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.brightBlue.color
            : Colors.white.withOpacity(0.7),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
