import 'package:flutter/material.dart';

class CheckIcon extends StatelessWidget {
  const CheckIcon({
    super.key,
  });

  final blueColor = const Color(0xFF0446F3);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: blueColor.withOpacity(0.25)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            width: size.width * .2,
            height: size.width * .2,
          ),
          Icon(
            Icons.check_circle_rounded,
            size: size.width * .3,
            color: blueColor,
          ),
        ],
      ),
    );
  }
}
