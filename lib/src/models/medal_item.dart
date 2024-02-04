

import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:h2o_keeper/src/models/record_model_ext.dart';

enum MedalKeep {
  day,
  week,
  month,
  month3,
  month6,
  year
}

extension MedalKeepExt on MedalKeep {
  String get name => describeEnum(this);
  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }
  String get ableIcon => "keep_$name.png";
  String get disableIcon => "keep_${name}_disable.png";

  String iconWith(List<RecordModel> records) {
    switch (this) {
      case MedalKeep.day:
        return judgetKeep(3, records) ? ableIcon : disableIcon;
      case MedalKeep.week:
        return judgetKeep(7, records) ? ableIcon : disableIcon;
      case MedalKeep.month:
        return judgetKeep(30, records) ? ableIcon : disableIcon;
      case MedalKeep.month3:
        return judgetKeep(90, records) ? ableIcon : disableIcon;
      case MedalKeep.month6:
        return judgetKeep(180, records) ? ableIcon : disableIcon;
      case MedalKeep.year:
        return judgetKeep(365, records) ? ableIcon : disableIcon;
    }
  }
}

bool judgetKeep(int day, List<RecordModel> records) {
  List<RecordModel> daysRecord = records.fold([], (previousValue, element) {
    bool exists = previousValue.any((e) => element.day == e.day);
    if (!exists) {
      previousValue.add(element);
    }
    return previousValue;
  });

  List<DateTime> dateTimes = daysRecord.map((e) => e.dateTime).toList();
  return checkConsecutiveDays(dateTimes, day);
}

// 日期数组是否有n个连续的日期
bool checkConsecutiveDays(List<DateTime> dateList, int consecutiveDays) {
  dateList.sort(); // 先对日期进行排序
  for (int i = 0; i <= dateList.length - consecutiveDays; i++) {
    bool isConsecutive = true;
    for (int j = 0; j < consecutiveDays - 1; j++) {
      // 检查当前日期和下一个日期是否连续
      if (dateList[i + j].add(const Duration(days: 1)) != dateList[i + j + 1]) {
        isConsecutive = false;
        break;
      }
    }
    if (isConsecutive) {
      return true;
    }
  }
  return false;
}



enum MedalGoal {
  one,
  ten,
  threety,
  hundred,
  hundred2,
  hundred3
}

extension MedalGoalExt on MedalGoal {
  String get name => describeEnum(this);
  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String get ableIcon => "goal_$name.png";
  String get disableIcon => "goal_${name}_disable.png";

  String iconWith(List<RecordModel> records) {
    switch (this) {
      case MedalGoal.one:
        return judgeGoal(1, records) ? ableIcon : disableIcon;
      case MedalGoal.ten:
        return judgeGoal(10, records) ? ableIcon : disableIcon;
      case MedalGoal.threety:
        return judgeGoal(30, records) ? ableIcon : disableIcon;
      case MedalGoal.hundred:
        return judgeGoal(100, records) ? ableIcon : disableIcon;
      case MedalGoal.hundred2:
        return judgeGoal(200, records) ? ableIcon : disableIcon;
      case MedalGoal.hundred3:
        return judgeGoal(300, records) ? ableIcon : disableIcon;
    }
  }
}

bool judgeGoal(int day, List<RecordModel> records) {
  if (records.isEmpty) {
      return false;
    }
  List<List<RecordModel>> dates = records.fold([[]], (previousValue, element) {
      final previous = previousValue;
      if (previous.isEmpty) {
        return [[element]];
      } else {
        List<RecordModel> r = previous[0] ;
        if (r.isEmpty) {
          return [[element]];
        }
        if (r[0].day == element.day) {
          r.add(element);
          previous[0] = r;
        } else {
          previous.insert(0, [element]);
        }
        return previous;
      }
    });
  List<MedalGoalModel> record = dates.map((e) {
    if (e.isEmpty) {
      return MedalGoalModel(goal: 0, ml: 0);
    } else {
      final total = e.map((e) => e.ml).reduce((value, element) => value + element);
      final goal = e[0].goal;
      return MedalGoalModel(goal: goal, ml: total);
    }
  }).toList();

  final targets = record.where((element) => element.ml >= element.goal);

  return targets.length >= day;
}

class MedalGoalModel {
  int goal = 0;
  int ml = 0;
  MedalGoalModel({required this.goal, required this.ml});
}