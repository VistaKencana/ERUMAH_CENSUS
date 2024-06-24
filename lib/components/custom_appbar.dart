import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final Color? foregroundColor;
  final bool gradientBg;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final double height;
  const CustomAppBar({
    super.key,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    required this.title,
    this.foregroundColor,
    this.gradientBg = false,
    this.actions,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          color: gradientBg ? null : Colors.transparent,
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
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            leading: automaticallyImplyLeading
                ? IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.chevron_left))
                : null,
            backgroundColor: Colors.transparent,
            foregroundColor:
                (foregroundColor ?? (gradientBg ? Colors.white : Colors.black)),
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: centerTitle,
            actions: actions,
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
