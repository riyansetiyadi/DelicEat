import 'package:flutter_test/flutter_test.dart';
import 'package:deliceat/utils/date_time_helper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  DateTimeHelper dateTimeHelper = DateTimeHelper();

  group('DateTimeHelper Function Test', () {
    late DateTime dateTime;
    late String dateTimeString;
    setUp(() {
      dateTime = DateTime(2023, 12, 30);
      dateTimeString = "30 Desember 2023";
    });

    test('DateTimeHelper().convertDateTimeToString should return String Datetime', () {
      String result = dateTimeHelper.convertDateTimeToString(dateTime);
      
      expect(result, "30 Desember 2023");
    });

    test('DateTimeHelper().convertStringToDateTime should return Datetime', () {
      DateTime result = dateTimeHelper.convertStringToDateTime(dateTimeString);
      
      expect(result, DateTime(2023, 12, 30));
    });
  });
}
