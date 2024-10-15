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
      color: bgColor ?? Colors.white,
      // color: bgColor ?? AppColors.primary.color,
      child: Row(children: List.generate(itemCount, generator)),
    );
  }
}

class NavItem extends StatelessWidget {
  final Icon icon;
  final String label;
  final Color? selectedBgColor;
  final Color? selectedColor;
  final bool isSelected;
  final Color unselectedBgColor;
  final int itemCount;
  final void Function()? onTap;
  const NavItem({
    super.key,
    required this.icon,
    this.selectedBgColor,
    this.selectedColor,
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
        decoration: BoxDecoration(
          border: const Border(top: BorderSide(color: Colors.black12)),
          color: isSelected
              ? (selectedBgColor ?? Colors.white.withOpacity(.1))
              : unselectedBgColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color:
                    AppColors.brightBlue.color.withOpacity(isSelected ? .2 : 0),
              ),
              child: Icon(
                icon.icon,
                color: isSelected
                    ? AppColors.brightBlue.color
                    : AppColors.brightBlue.color.withOpacity(.5),
                size: icon.size,
              ),
            ),
            Text(label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    color: selectedColor ?? AppColors.brightBlue.color,
                    fontSize: 12))
          ],
        ),
      ),
    );
  }
}
