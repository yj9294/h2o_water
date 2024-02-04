

extension DateTimeExt on DateTime {
  bool get isWeekend {
    return weekday == DateTime.saturday || weekday == DateTime.sunday;
  }
}