import 'package:flutter/material.dart';
import '../config/constants/app_images.dart';

class BgImage extends StatelessWidget {
  final Widget child;
  final String? bgPath;
  const BgImage({super.key, required this.child, this.bgPath});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bgPath ?? AppImages.bg.path),
                  fit: BoxFit.fill)),
        ),
        child,
      ],
    );
  }
}
