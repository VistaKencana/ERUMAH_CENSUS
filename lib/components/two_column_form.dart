import 'package:eperumahan_bancian/config/constants/app_size.dart';
import 'package:flutter/material.dart';

class TwoColumnForm extends StatelessWidget {
  final List<Widget> children;
  const TwoColumnForm({super.key, this.children = const <Widget>[]});

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of items per row
        childAspectRatio:
            AppSize().getGridAspectRatio(), // Aspect ratio of each item
        mainAxisSpacing: 10.0, // Spacing between rows
        crossAxisSpacing: 10.0, // Spacing between columns
      ),
      children: children,
    );
  }
}
