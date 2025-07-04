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
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12))),
      child: SizedBox(
          height: 50,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
              onPressed: onTap,
              child: Text(title))),
    );
  }
}
