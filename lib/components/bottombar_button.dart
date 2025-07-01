import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const BottomBarButton({
    super.key,
    required this.onTap,
    required this.title,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: SizedBox(
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  foregroundColor: foregroundColor),
              onPressed: onTap,
              child: Text(title))),
    );
  }
}
