

import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/models/record_item.dart';
import 'package:intl/intl.dart';

enum ChartsItem {
  day,
  week,
  month,
  year
}

extension ChartsItemExt on ChartsItem {
  String get name => describeEnum(this);
  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String get title => name.capitalize();

  String get localTitle {
    switch (this) {
      case ChartsItem.day:
      return S.current.day;
      case ChartsItem.week:
      return S.current.week;
      case ChartsItem.month:
      return S.current.month;
      case ChartsItem.year:
      return S.current.year;
    }
  }
}

extension DateTimeExt on DateTime {
  String get dateString {
    final formatter = DateFormat("yyyy-MM-dd");
    return formatter.format(this);
  }
}

extension StringDateExt on String {
  String get dateString {
    final year = DateTime.now().year;
    final formatter = DateFormat("yyyy/MM/dd");
    final date = formatter.parse("$year/$this");
    final form = DateFormat("yyyy-MM-dd");
    return form.format(date);
  }
}