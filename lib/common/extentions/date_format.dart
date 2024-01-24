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

  String toFormatDateParams() {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

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
}
