import 'package:intl/intl.dart';

String getFormattedDate(String date) {
  return DateFormat("dd/MM/yyyy").format(DateTime.parse(date));
}
