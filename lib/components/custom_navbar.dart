import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final Color bgColor;
  final int itemCount;
  final Widget Function(int) generator;
  const CustomBottomNav(
    this.generator, {
    super.key,
    // this.bgColor = const Color(0xFF312D81),
    this.bgColor = Colors.white,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: bgColor,
          border: Border(top: BorderSide(color: Colors.grey.shade300))),
      child: Row(children: List.generate(itemCount, generator)),
    );
  }
}

class NavItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final Color selectedBgColor;
  final Color selectedColor;
  final bool isSelected;
  final Color unselectedBgColor;
  final int itemCount;
  final void Function()? onTap;
  const NavItem({
    super.key,
    required this.icon,
    this.selectedBgColor = const Color(0xFF096B6C),
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
      child: AnimatedContainer(
        height: 60,
        width: size.width / itemCount,
        // color: isSelected ? selectedBgColor : unselectedBgColor,
        color: Colors.white,
        duration: const Duration(milliseconds: 300),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (icon is Icon)
                ? Icon((icon as Icon).icon,
                    color: isSelected
                        ? selectedBgColor
                        : Colors.black.withValues(alpha: .8),
                    size: (icon as Icon).size)
                : icon,
            Visibility(
              visible: isSelected && label.isNotEmpty,
              child: Text(label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                      color: isSelected ? selectedBgColor : Colors.black,
                      fontSize: 12)),
            )
          ],
        ),
      ),
    );
  }
}
