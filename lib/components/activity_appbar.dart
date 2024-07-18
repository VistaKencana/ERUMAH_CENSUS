import 'package:eperumahan_bancian/screens/activity/model/bancian_info.dart';
import 'package:eperumahan_bancian/screens/bancian-forms/bancian_tingkat_modal.dart';
import 'package:flutter/material.dart';

import '../config/constants/app_colors.dart';

class ActivityAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color? foregroundColor;
  final bool gradientBg;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final double height;
  final void Function()? onPressedBack;
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
  });

  @override
  Widget build(BuildContext context) {
    final info = BancianInfo.getExampleData();
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
                // Text(
                //   "Info Kawasan Bancian",
                //   style: appTextStyle(
                //       fontWeight: FontWeight.w400,
                //       color: AppColors.dimmedPurple.color),
                // ),

                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: appTextStyle(fontWeight: FontWeight.bold, size: 20),
                ),
                Text(
                  "${info[0].value} • ${info[2].title} ${info[2].value}",
                  style: appTextStyle(fontWeight: FontWeight.normal, size: 14),
                ),
              ],
            ),
            centerTitle: centerTitle,
            actions: actions,
            bottom: bottom,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 20.0),
          //   child: Text(
          //     "${info[0].value} • ${info[2].title} ${info[2].value} • ${info[3].title} ${info[3].value}",
          //     style: appTextStyle(fontWeight: FontWeight.bold),
          //   ),
          // ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              const BancianTingkatModal().show(context);
            },
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
                    "20",
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
