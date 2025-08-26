import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  return DateFormat('d MMMM - hh:mm a', 'ar').format(dateTime);
}
String formatDate(DateTime dateTime) {
  return DateFormat('d MMMM yyyy', 'ar').format(dateTime);
}
