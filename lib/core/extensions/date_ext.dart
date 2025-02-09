import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String get formattedTime {
    return DateFormat('HH:mm').format(this);
  }

  String get formattedDate {
    final weekday = '${DateFormat('E', 'de').format(this)}.';
    final day = this.day;
    final month = '${DateFormat('MMM', 'de').format(this)}.';
    return '$weekday $day. $month';
  }
}
