import 'package:flutter/material.dart';

class ModalHandler extends StatelessWidget implements PreferredSizeWidget {
  const ModalHandler({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(18);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 5,
        width: 60,
      ),
    );
  }
}
