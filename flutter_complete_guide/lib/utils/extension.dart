import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }

  MediaQueryData get media {
    return MediaQuery.of(this);
  }

  NavigatorState get navigator {
    return Navigator.of(this);
  }

  ModalRoute get route {
    return ModalRoute.of(this);
  }

  Object get routeArg {
    return this.route.settings.arguments;
  }
}

extension DateTimeExt on DateTime {
  String csToString(String formatString) {
    var format = DateFormat(formatString);
    return format.format(this);
  }

  DateTime startOfDate() {
    return DateTime(this.year, this.month, this.day);
  }

  DateTime endOfDate() {
    return DateTime(this.year, this.month, this.day, 23, 59, 59);
  }

  //Start at Monday
  static List<DateTime> dateInWeekByDate(DateTime date) {
    final now = DateTime.now().startOfDate();
    final weekDay = date.weekday;
    final result = <DateTime>[];
    for (var i = 1; i <= 7; i++) {
      final calculate = now.add(Duration(days: i - weekDay));
      result.add(calculate);
    }

    return result;
  }
}

extension IterableExt on Iterable {
  Iterable shift(int number) {
    if (number <= 0) {
      return this;
    }

    final sub = this.length - number;
    return Iterable.generate(this.length, (index) {
      if (sub + index < this.length) {
        return this.elementAt(sub + index);
      } else {
        return this.elementAt(index - number);
      }
    });
  }
}

extension MediaQueryDataExt on MediaQueryData {
  double get contentHeight {
    return this.size.height - this.padding.top;
  }
}

extension ColorExt on Color {
  Color withPercentAlpha(double percent) {
    if (percent >= 1) {
      return this;
    }

    return this.withAlpha((255 * percent).toInt());
  }
}
