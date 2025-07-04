import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget? child;
  final BoxBorder? border;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  const SectionContainer(
      {super.key,
      this.child,
      this.margin,
      this.padding,
      this.border,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
          border: border,
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
