import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  final Widget? child;
  const SectionContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
