import 'package:flutter/material.dart';

class CustomPersistentHeader extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  CustomPersistentHeader({required this.child, this.height = 54});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              offset: const Offset(0.0, 2.0), //(x,y)
              blurRadius: 2.0,
            ),
          ],
        ),
        // padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        height: height,
        child: child);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
