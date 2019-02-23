import 'package:date_format/date_format.dart';

class DateFormat {
  static String getDateFormat(String date) {
    return formatDate(DateTime.parse(date), [d, '-', M, '-', yyyy, ' ', HH, ':', nn, ':', ss]);
  }
}
