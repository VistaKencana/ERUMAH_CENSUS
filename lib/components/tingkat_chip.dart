import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TingkatChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function()? onPressed;
  const TingkatChip(
      {super.key, required this.title, this.isSelected = true, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: onPressed,
      color: WidgetStatePropertyAll(
          isSelected ? AppColors.primary.color : Colors.white),
      label: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 45, maxHeight: 22),
        child: Center(
          child: Text(
            title,
            style: appTextStyle(
                size: 14,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
      shape: const StadiumBorder(),
      side: BorderSide(color: isSelected ? Colors.transparent : Colors.black26),
    );
  }
}
