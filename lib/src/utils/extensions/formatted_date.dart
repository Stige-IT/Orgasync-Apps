import 'package:intl/intl.dart';

extension DateFormater on String {
  timeFormat() {
    DateTime date = DateTime.parse(this);
    return DateFormat("dd MMMM yyyy, HH:mm", "id_ID").format(date);
  }

  dateFormat() {
    DateTime date = DateTime.parse(this);
    return DateFormat("dd MMM yyyy", "id_ID").format(date);
  }

  dateFormatWithDay() {
    if (this != "") {
      DateTime date = DateTime.parse(this);
      return DateFormat("EEEE ,dd MMMM yyyy", "id_ID").format(date);
    }
  }
}