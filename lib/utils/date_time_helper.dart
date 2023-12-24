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

  static DateTime getNotificationSchedule() {
    final now = DateTime.now();
    final dateFormat = DateFormat('y/M/d');
    const timeSpecific = "11:00:00";
    final completeFormat = DateFormat('y/M/d H:m:s');

    final todayDate = dateFormat.format(now);
    final todayDateAndTime = "$todayDate $timeSpecific";
    var resultToday = completeFormat.parseStrict(todayDateAndTime);

    var formatted = resultToday.add(const Duration(days: 1));
    final tomorrowDate = dateFormat.format(formatted);
    final tomorrowDateAndTime = "$tomorrowDate $timeSpecific";
    var resultTomorrow = completeFormat.parseStrict(tomorrowDateAndTime);

    return now.isAfter(resultToday) ? resultTomorrow : resultToday;
  }
}
