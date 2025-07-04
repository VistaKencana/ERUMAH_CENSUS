import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final Widget Function(BuildContext context) builder;
  final bool useCustomAnimation;
  final Animation<double>? animation;
  final Widget Function(Animation<double> animation, Widget child)?
      animationBuilder;
  final bool barrierDismissible;

  const CustomDialog({
    super.key,
    required this.builder,
    this.useCustomAnimation = false,
    this.animation,
    this.animationBuilder,
    this.barrierDismissible = true,
  });

  @override
  State<CustomDialog> createState() => _CustomDialogState();

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget Function(BuildContext context) builder,
    bool useCustomAnimation = false,
    Animation<double>? animation,
    Widget Function(Animation<double> animation, Widget child)?
        animationBuilder,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (ctx) => CustomDialog(
        builder: builder,
        useCustomAnimation: useCustomAnimation,
        animation: animation,
        animationBuilder: animationBuilder,
        barrierDismissible: barrierDismissible,
      ),
    );
  }
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    final child = widget.builder(context);

    if (!widget.useCustomAnimation) {
      return child;
    }

    final animation = widget.animation ??
        CurvedAnimation(
          parent: ModalRoute.of(context)!.animation!,
          curve: Curves.easeOut,
          reverseCurve: Curves.easeIn,
        );

    if (widget.animationBuilder != null) {
      return widget.animationBuilder!(animation, child);
    }

    // Default: Fade + Scale transition
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(scale: animation, child: child),
    );
  }
}
