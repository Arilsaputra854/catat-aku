import 'package:intl/intl.dart';

class DateFormatter {
  static String convertToString(DateTime date) {
    var format = DateFormat("EEEE, dd MMMM yyyy", "id_ID");

    return format.format(date);
  }
}
