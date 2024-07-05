import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const BottomBarButton({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: SizedBox(
          height: 50,
          child: ElevatedButton(onPressed: onTap, child: Text(title))),
    );
  }
}
