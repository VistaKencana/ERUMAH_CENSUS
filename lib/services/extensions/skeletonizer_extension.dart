import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

extension SkeletonizerExtension on Widget {
  /// Wraps any widget with Skeletonizer, based on [isLoading] flag.
  Widget withSkeleton({
    required bool isLoading,
    bool? justifyMultiLineText,
    TextBoneBorderRadius? textBoneBorderRadius,
  }) {
    return Skeletonizer(
      enabled: isLoading,
      justifyMultiLineText: justifyMultiLineText,
      textBoneBorderRadius: textBoneBorderRadius,
      child: this,
    );
  }

  /// Loading will not render this widget
  Widget ignoreRenderSkeleton() {
    return Skeleton.ignore(child: this);
  }

  /// Keep original widget from being skeletonize
  Widget skeletonKeepOrigin() {
    return Skeleton.keep(child: this);
  }

  /// Skeletonize the widget into their original shape e.g Icon
  Widget skeletonShade() {
    return Skeleton.shade(child: this);
  }
}

extension SkeletonListExtension on List<Widget> {
  /// Wraps each widget in the list with a skeleton, optionally using a custom count placeholder
  List<Widget> withSkeletonItems(bool isLoading, {int placeholderCount = 3}) {
    if (!isLoading) return this;

    return List.generate(placeholderCount, (index) {
      return Skeletonizer(
        enabled: true,
        child: isNotEmpty ? first : const SizedBox(),
      );
    });
  }
}

class MockData<T> {
  final String _word;

  MockData([this._word = 'Moock']);

  List<T> generateData(T Function(MockData dummyData, int index) generator,
      {int count = 10}) {
    return List.generate(count, (cntIndex) => generator(this, cntIndex));
  }

  String chars(int charNo, [String char = 'C']) => char * charNo;
  String words(int words) => _word * words;

  String get title => _word * 2;
  String get subtitle => _word * 3;
  String get name => _word * 2;
  String get fullName => _word * 3;
  String get paragraph => _word * 20;
  String get longParagraph => _word * 50;

  String get date => chars(10);
  String get time => chars(5);
  String get phone => chars(12);
  String get email => chars(18);
  String get address => chars(30);
  String get city => chars(15);
  String get country => chars(15);
}
