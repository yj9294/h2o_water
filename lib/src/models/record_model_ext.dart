import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:intl/intl.dart';

extension RecordModelExt on RecordModel {
    bool isToday() {
    var formatter = DateFormat("yyyy-MM-dd");
    final date = formatter.parse(day);
    return isSameDay(DateTime.now(), date);
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  DateTime get dateTime {
    final formatter = DateFormat("yyyy-MM-dd");
    return formatter.parse(day);
  }
}