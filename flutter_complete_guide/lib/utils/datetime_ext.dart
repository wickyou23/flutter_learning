import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String csToString(String formatString) {
    var format = DateFormat(formatString);
    return format.format(this);
  }

  static List<DateTime> dateInWeekByDate(DateTime date) {
    final now = DateTime.now();
    final weekDay = date.weekday;
    final result = <DateTime>[]; 
    for (var i = 1; i <= 7; i++) {
      final calculate = now.add(Duration(days: i - weekDay));
      result.add(calculate);
    }

    return result;
  }
}