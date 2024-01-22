import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toFormatShift() {
    DateFormat dateFormat = DateFormat("HH:mm");

    return dateFormat.format(this);
  }

  String toFormatDateRange() {
    DateFormat dateFormat = DateFormat('dd MMM yyyy');

    return dateFormat.format(this);
  }

  String toFormatAttendance() {
    DateFormat dateFormat = DateFormat("HH:mm:ss");

    return dateFormat.format(this);
  }

  String toFormatDateParams() {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    return dateFormat.format(this);
  }

  String toFormatDateTimeParams() {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    return dateFormat.format(this);
  }

  String toFormatTimeParams() {
    DateFormat dateFormat = DateFormat('HHmmss');

    return dateFormat.format(this);
  }

  String toFormatDayShift() {
    DateFormat dateFormat = DateFormat('E, dd');

    return dateFormat.format(this);
  }

  String toFormatDayShiftHistory() {
    DateFormat dateFormat = DateFormat('EEEE\ndd MMM');

    return dateFormat.format(this);
  }

  String toFormatDayIndonesian() {
    DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy');

    return dateFormat.format(this);
  }

  String toFormatDateTimeIndonesian() {
    DateFormat dateFormat = DateFormat('EEEE, dd MMMM yyyy HH:mm:ss');

    return dateFormat.format(this);
  }

  String toFormatTime() {
    DateFormat dateFormat = DateFormat('HH : mm : ss');

    return dateFormat.format(this);
  }

  String toDayName() {
    DateFormat dateFormat = DateFormat('EEEE,');

    return dateFormat.format(this);
  }

  String toDay() {
    DateFormat dateFormat = DateFormat('dd');

    return dateFormat.format(this);
  }

  String toFormatPayslipRecapitulation() {
    DateFormat dateFormat = DateFormat('dd MMMM');

    return dateFormat.format(this);
  }

  String formatTimeAndZone() {
    DateFormat dateFormat = DateFormat('dd MMMM yyyy');

    return dateFormat.format(this);
  }

  String toFormatDateAndTime({
    String format = 'dd MMMM yyyy, HH:mm',
  }) {
    DateFormat dateFormat = DateFormat(format);

    return dateFormat.format(toLocal());
  }

  DateTime toFormatDate({
    String format = 'yyyy-MM-dd',
  }) {
    DateFormat dateFormat = DateFormat(format);

    return dateFormat.parse(toString().split('.').first);
  }

  String toSubstituteName() {
    final now = DateTime.now();
    final isNow = now.day == day && now.month == month && now.year == year;
    if (isNow) return 'Hari ini';

    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final isYesterday = yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
    if (isYesterday) return 'Kemarin';

    return toFormatDateRange();
  }

  String toFormatYearAndMonth() {
    DateFormat dateFormat = DateFormat('yyyy MMMM');

    return dateFormat.format(this);
  }
}

extension StringTimeX on String {
  DateTime toFormatDateTime() {
    ///before parse => "01/12/2022"
    ///after parse => "2022-12-01"
    var parts = split('/');

    return DateTime.parse("${parts[2]}-${parts[1]}-${parts.first}");
  }

  String formatTimeAndZone() {
    DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").parse(this);

    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd MMMM yyyy');

    return outputFormat.format(inputDate);
  }
}

extension DateTimeRangeX on DateTimeRange {
  List<DateTime> get eachDay {
    final start = DateUtils.dateOnly(this.start);
    final end = DateUtils.dateOnly(this.end);

    List<DateTime> iterated = [];
    if (start.month < end.month || start.year < end.year) {
      for (var day = start.day;
          day <= DateUtils.getDaysInMonth(start.year, start.month);
          day++) {
        iterated.add(start.add(Duration(days: day - start.day)));
      }
      for (var day = 1; day <= end.day; day++) {
        iterated.add(DateTime(end.year, end.month, day));
      }
    } else {
      for (var day = start.day; day <= end.day; day++) {
        iterated.add(start.add(Duration(days: day - start.day)));
      }
    }

    return iterated;
  }
}
