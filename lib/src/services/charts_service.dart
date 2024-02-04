
import 'package:flutter/cupertino.dart';
import 'package:h2o_keeper/src/models/charts_item.dart';
import 'package:h2o_keeper/src/models/charts_model.dart';
import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:h2o_keeper/src/services/record_service.dart';
import 'package:h2o_keeper/src/utils/cache_util.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ChartsLogic extends ChangeNotifier {
  ChartsLogic() {
    CacheUtil().getRecords().then((value) => updateRecord(value));
  }
  ChartsItem _item = ChartsItem.day;
  ChartsItem get item => _item;
  void updateItem(ChartsItem item) {
    _item = item;
    if (item == ChartsItem.year) {
      chartsLeft = [75000, 60000, 30000, 15000, 0];
    } else {
      chartsLeft = [2500, 2000, 1500, 500, 0];
    }
    notifyListeners();
  }

  List<int> chartsLeft = [2500, 2000, 1500, 500, 0];
  List<RecordModel> _records = [];
  List<RecordModel> get records => _records;
  void updateRecord(List<RecordModel> recors) {
    _records = recors;
    notifyListeners();
  }

  List<String> get unitModel {
    switch (_item) {
      case ChartsItem.day:
        final times = records.where((element) => element.day == DateTime.now().dayString).map((e) => e.time);
        return times.fold<List<String>>([], (previousValue, element) {
          if (previousValue.contains(element)) {
            return previousValue;
          } else {
            return previousValue + [element];
          }
        });
      case ChartsItem.week:
        return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
      case ChartsItem.month:
        List<String> days = [];
        for(int i = 0; i < 30; i++) {
          var formatter = DateFormat("MM/dd");
          final date = DateTime.now().subtract(Duration(days: i));
          final day = formatter.format(date);
          days.insert(0, day);
        }
        return days;
      case ChartsItem.year:
        List<String> months = [];
        for(int i = 0; i < 12; i++) {
          var formatter = DateFormat("MMM");
          final now = DateTime.now();
          final date = DateTime(now.year, now.month - i, now.day);
          final day = formatter.format(date);
          months.insert(0, day);
        }
        return months;
    }
  }

  List<ChartsModel> get chartsModels {
    double max = 2500.0;
    switch (_item) {
      case ChartsItem.day:
        return unitModel.map((e) {
          final total = records.where((element) => element.day == DateTime.now().dayString && e == element.time).map((e) => e.ml).reduce((value, element) {
            return value + element;
          });
          return ChartsModel(id: const Uuid().v4(), progress: total / max , ml: total, unit: e);
        }).toList();
      case ChartsItem.week:
        return unitModel.map((e) {
          final week = unitModel.indexOf(e);
          final thisWeeks = getThisWeekDates(DateTime.now());
          final date = thisWeeks[(week + 6) % 7];

          final dateFormatter = DateFormat("yyyy-MM-dd");
          final targetString = dateFormatter.format(date);

          final mls = records
              .where((element) => element.day == targetString)
              .map((e) => e.ml);
          if (mls.isEmpty) {
            return ChartsModel(id: const Uuid().v4(), progress: 0 , ml: 0, unit: e);
          }
          final total = mls.reduce((value, element) {
                return value + element;
          });
          return ChartsModel(id: const Uuid().v4(), progress: total / max , ml: total, unit: e);
        }).toList();
      case ChartsItem.month:
        return unitModel.map((e) {
          final mls = records.where((element) {
            return element.day == e.dateString;
          }).map((e) => e.ml);
          if (mls.isEmpty) {
            return ChartsModel(id: const Uuid().v4(), progress: 0 , ml: 0, unit: e);
          } else {
            final total = mls.reduce((value, element) => value + element);
            return ChartsModel(id: const Uuid().v4(), progress: total / max , ml: total, unit: e);
          }
        }).toList();
      case ChartsItem.year:
        max = 2500 * 30;
        return unitModel.map((e) {
          final mls = records.where((element) {
            final dateFormat = DateFormat("yyyy-MM-dd");
            final date = dateFormat.parse(element.day);
            final dateFormate2 = DateFormat("MMM");
            final m = dateFormate2.format(date);
            return m == e;
          }).map((e) => e.ml);
          if (mls.isEmpty) {
            return ChartsModel(id: const Uuid().v4(), progress:  0 , ml: 0, unit: e);
          } else {
            final total = mls.reduce((value, element) => value + element);
            return ChartsModel(id: const Uuid().v4(), progress: total / max , ml: total, unit: e);
          }
        }).toList();
    }
  }

  List<DateTime> getThisWeekDates(DateTime date) {
    int currentWeekday = date.weekday;
    DateTime monday = date.subtract(Duration(days: currentWeekday - 1));

    List<DateTime> weekDates = [];

    for (int i = 0; i < 7; i++) {
      DateTime day = monday.add(Duration(days: i));
      weekDates.add(DateTime(day.year, day.month, day.day));
    }

    return weekDates;
  }

}
