import 'package:intl/intl.dart';

extension StringExtensions on String {
  /// Formats all numbers in the string to two decimal places.
  String formatToTwoDecimals() {
    return replaceAllMapped(RegExp(r'(\d+(\.\d{0,2})?)'), (match) {
      final num = double.tryParse(match.group(0)!);
      return num?.toStringAsFixed(2) ?? match.group(0)!;
    });
  }

  /// Converts a string number to two decimal places, or returns original string if invalid.
  String toTwoDecimalPoints() {
    final num = double.tryParse(this);
    return num?.toStringAsFixed(2) ?? this;
  }

  /// Truncates the string with a middle ellipsis if it exceeds [maxLength].
  String middleEllipsis(int maxLength) {
    if (length <= maxLength) return this;
    const ellipsis = '...';
    final prefix = (maxLength - ellipsis.length) ~/ 2;
    final suffix = maxLength - ellipsis.length - prefix;
    return '${substring(0, prefix)}$ellipsis${substring(length - suffix)}';
  }

  /// Converts an ISO or common date string to a DateTime.
  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (_) {
      return null; // Return null if the format is invalid
    }
  }

  /// Formats a date string to a specified format (default is 'dd MMM yyyy').
  String formatDate([String pattern = 'dd MMM yyyy']) {
    final date = toDateTime();
    if (date == null) return this; // Return original string if parsing fails
    return DateFormat(pattern).format(date);
  }
}

extension TimeRangeSorting on List<String> {
  /// Sorts time ranges (e.g., "09:00 AM - 10:00 AM") by their start time and removes duplicates.
  void sortTimeRanges() {
    DateTime parseTime(String time) {
      final match = RegExp(r'(\d{2}):(\d{2})\s(AM|PM)').firstMatch(time);
      if (match == null) throw const FormatException('Invalid time format');

      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String period = match.group(3)!;

      if (period == 'AM' && hour == 12) hour = 0;
      if (period == 'PM' && hour != 12) hour += 12;

      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, hour, minute);
    }

    final unique = toSet().toList();
    unique.sort((a, b) {
      final aStart = parseTime(a.split('-')[0].trim());
      final bStart = parseTime(b.split('-')[0].trim());
      return aStart.compareTo(bStart);
    });

    clear();
    addAll(unique);
  }
}
