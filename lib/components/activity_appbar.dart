import 'package:eperumahan_bancian/config/constants/app_images.dart';
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
    this.height = 145,
    this.onPressedBack,
    this.bottom,
    required this.subtitle,
    required this.floor,
    required this.onOpenFloor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.greenBg.path), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.midGrey.color,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // AppBar(
          //   surfaceTintColor: Colors.white,
          //   automaticallyImplyLeading: false,
          //   backgroundColor: Colors.transparent,
          //   foregroundColor:
          //       (foregroundColor ?? (gradientBg ? Colors.white : Colors.black)),
          //   // leading: automaticallyImplyLeading
          //   //     ? IconButton(
          //   //         onPressed: () {
          //   //           if (onPressedBack != null) {
          //   //             onPressedBack!();
          //   //             return;
          //   //           }
          //   //           Navigator.pop(context);
          //   //         },
          //   //         icon: const Icon(Icons.chevron_left))
          //   //     : null,
          //   leading:
          //   title: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         title,
          //         overflow: TextOverflow.ellipsis,
          //         style: appTextStyle(fontWeight: FontWeight.bold, size: 20),
          //       ),
          //       Text(
          //         subtitle,
          //         style: appTextStyle(fontWeight: FontWeight.normal, size: 14),
          //       ),
          //     ],
          //   ),
          //   centerTitle: centerTitle,
          //   actions: actions,
          //   bottom: bottom,
          // ),
          const SizedBox(height: 20),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: appTextStyle(
              fontWeight: FontWeight.bold,
              size: 20,
              color: AppColors.midGrey.color,
            ),
          ),
          Text(
            subtitle,
            style: appTextStyle(
              fontWeight: FontWeight.normal,
              size: 14,
              color: AppColors.midGrey.color,
            ),
          ),
          const Spacer(),
          // GestureDetector(
          //   onTap: onOpenFloor,
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(horizontal: 16),
          //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(20),
          //         color: AppColors.midGrey.color),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           "Tingkat",
          //           style: appTextStyle(fontWeight: FontWeight.bold, size: 17),
          //         ),
          //         const Spacer(),
          //         Text(
          //           floor,
          //           style: appTextStyle(fontWeight: FontWeight.bold, size: 17),
          //         ),
          //         const SizedBox(width: 10),
          //         const Icon(Icons.arrow_drop_down)
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
