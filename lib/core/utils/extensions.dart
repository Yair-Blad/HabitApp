import 'package:flutter/material.dart';

extension ColorExtension on int {
  Color get toColor => Color(this);

  Color withOpacityValue(double opacity) => Color(this).withOpacity(opacity);
}

extension DateTimeExtension on DateTime {
  String get toDateString {
    return toIso8601String().split('T').first;
  }

  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}
