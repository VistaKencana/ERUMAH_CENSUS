import 'package:flutter/material.dart';

class TwoColumnForm extends StatelessWidget {
  final List<Widget> children;
  const TwoColumnForm({super.key, this.children = const <Widget>[]});

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items per row
        childAspectRatio: 16 / 8, // Aspect ratio of each item
        mainAxisSpacing: 10.0, // Spacing between rows
        crossAxisSpacing: 10.0, // Spacing between columns
      ),
      children: children,
    );
  }
}
