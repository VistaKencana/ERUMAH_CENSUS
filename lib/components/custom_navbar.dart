import 'package:eperumahan_bancian/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final Color? bgColor;
  final int itemCount;
  final Widget Function(int) generator;
  const CustomBottomNav(
    this.generator, {
    super.key,
    this.bgColor,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: bgColor ?? AppColors.primary.color,
      child: Row(children: List.generate(itemCount, generator)),
    );
  }
}

class NavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color? selectedBgColor;
  final Color selectedColor;
  final bool isSelected;
  final Color unselectedBgColor;
  final int itemCount;
  final void Function()? onTap;
  const NavItem({
    super.key,
    required this.icon,
    this.selectedBgColor,
    this.selectedColor = Colors.white,
    required this.isSelected,
    this.unselectedBgColor = Colors.transparent,
    required this.label,
    required this.itemCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        if (isSelected) return;
        if (onTap != null) onTap!();
      },
      child: Container(
        height: 60,
        width: size.width / itemCount,
        color: isSelected
            ? (selectedBgColor ?? Colors.white.withOpacity(.1))
            : unselectedBgColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Text(label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(color: selectedColor, fontSize: 12))
          ],
        ),
      ),
    );
  }
}
