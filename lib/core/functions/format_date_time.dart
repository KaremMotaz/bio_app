import 'package:intl/intl.dart';

String formatMonth(DateTime dateTime) {
  return DateFormat('MMMM', 'ar').format(dateTime);
}

String formatDay(DateTime dateTime) {
  return DateFormat('d').format(dateTime);
}

String formatTime(DateTime dateTime) {
  return DateFormat('h:mm').format(dateTime);
}

String formatPmOrAm(DateTime dateTime) {
  return DateFormat('a').format(dateTime);
}

String formatExamTime(DateTime startTime, DateTime endTime) {
  return "تاريخ الإمتحان: ${formatDay(startTime)} ${formatMonth(startTime)} "
      "(${formatTime(endTime)} - ${formatTime(startTime)}) ${formatPmOrAm(startTime)}";
}
