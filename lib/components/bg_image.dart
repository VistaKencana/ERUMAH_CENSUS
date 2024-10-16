import 'package:flutter/material.dart';
import '../config/constants/app_images.dart';

class BgImage extends StatelessWidget {
  final Widget child;
  final String? assetName;
  const BgImage({super.key, required this.child, this.assetName});

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
                  image: AssetImage(assetName ?? AppImages.comp2Bg.path),
                  fit: BoxFit.fill)),
        ),
        child,
      ],
    );
  }
}
