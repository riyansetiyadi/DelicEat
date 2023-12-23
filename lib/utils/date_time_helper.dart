import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateTimeHelper {
  DateTimeHelper() {
    Intl.defaultLocale = 'id';
    initializeDateFormatting();
  }

  DateTime convertStringToDateTime(String dateString) {
    final formatter = DateFormat('dd MMMM yyyy', 'id');

    DateTime dateTime = formatter.parse(dateString);

    return dateTime;
  }

  String convertDateTimeToString(DateTime dateTime) {
    final formatter = DateFormat('dd MMMM yyyy', 'id');

    String dateString = formatter.format(dateTime);

    return dateString;
  }
}
