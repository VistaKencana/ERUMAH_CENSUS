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
    this.height = 105,
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
          color: gradientBg ? null : Colors.white,
          gradient: gradientBg
              ? const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF04053D),
                    Color(0xFF0B0DA3),
                  ],
                )
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            surfaceTintColor: Colors.white,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            foregroundColor:
                (foregroundColor ?? (gradientBg ? Colors.white : Colors.black)),
            leading: automaticallyImplyLeading
                ? IconButton(
                    onPressed: () {
                      if (onPressedBack != null) {
                        onPressedBack!();
                        return;
                      }
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.chevron_left))
                : null,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: appTextStyle(fontWeight: FontWeight.bold, size: 20),
                ),
                Text(
                  subtitle,
                  style: appTextStyle(fontWeight: FontWeight.normal, size: 14),
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
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
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
