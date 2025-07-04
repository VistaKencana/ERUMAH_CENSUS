import 'package:flutter/material.dart';

import '../config/constants/app_colors.dart';

class ActivityAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final String floor;
  final bool centerTitle;
  final Color? foregroundColor;
  final bool gradientBg;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final double height;
  final void Function()? onPressedBack;
  final void Function() onOpenFloor;
  final PreferredSizeWidget? bottom;
  const ActivityAppbar({
    super.key,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    required this.title,
    this.foregroundColor,
    this.gradientBg = false,
    this.actions,
    this.height = 140,
    this.onPressedBack,
    this.bottom,
    required this.subtitle,
    required this.floor,
    required this.onOpenFloor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: AppColors.primary.color,
          gradient: gradientBg
              ? LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFFBA2C45), // 0%
                    Color(0xFF040001), // 100%
                  ],
                )
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          AppBar(
            surfaceTintColor: Colors.white,
            automaticallyImplyLeading: false,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor:
                (foregroundColor ?? (gradientBg ? Colors.white : Colors.white)),
            leading: automaticallyImplyLeading
                ? IconButton(
                    onPressed: () {
                      if (onPressedBack != null) {
                        onPressedBack!();
                        return;
                      }
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                    ))
                : null,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: appTextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      size: 20),
                ),
                Text(
                  subtitle,
                  style: appTextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      size: 14),
                ),
              ],
            ),
            centerTitle: centerTitle,
            actions: actions,
            bottom: bottom,
          ),
          const Spacer(),
          GestureDetector(
            onTap: onOpenFloor,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.midGrey.color),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tingkat",
                    style: appTextStyle(fontWeight: FontWeight.bold, size: 17),
                  ),
                  const Spacer(),
                  Text(
                    floor,
                    style: appTextStyle(fontWeight: FontWeight.bold, size: 17),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
