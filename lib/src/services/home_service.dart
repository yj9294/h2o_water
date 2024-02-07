
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:h2o_keeper/src/models/language_item.dart';
import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:h2o_keeper/src/models/record_model_ext.dart';
import 'package:h2o_keeper/src/models/tabbar_item.dart';
import 'package:h2o_keeper/src/utils/cache_util.dart';
import 'package:h2o_keeper/src/utils/notification_util.dart';

class HomeLogic extends ChangeNotifier {

  HomeLogic() {
    CacheUtil().getRecords().then((value) => notifyRecords(value));
    CacheUtil().getGoal().then((value) => updateGoal(value));
    CacheUtil().getLanguage().then((value) {
      LanguageItem item = EnumToString.fromString(LanguageItem.values, value) ?? LanguageItem.english;
      updateLanguage(item.languageCode);
    });
  }
  
  // 选中的 tabbar
  TabbarItem _item = TabbarItem.drink;
  TabbarItem get item => _item;

  // 饮水记录
  List<RecordModel> _records = [];
  List<RecordModel> get records => _records;
  // 总目标
  int _goal = 0;
  int get goal => _goal;
  // 进度
  int get progress {
    if (today == 0.0) {
      return 0;
    }
    return (today.toDouble() / goal.toDouble() * 100).toInt();
  }

  // 当天引水量
  int get today {
    final mls = _records.where((element) => element.isToday()).map((e) => e.ml);
    if (mls.isEmpty) {
      return 0;
    }
    return mls.reduce((value, element) => value + element);
  }

  void updateItem(TabbarItem item) {
    _item = item;
    notifyListeners();
  }

  void notifyRecords(List<RecordModel> records) {
    _records = records;
    notifyListeners();
  }

  void appendRecord(RecordModel record) {
    _records.add(record);
    CacheUtil().appendRecord(record);
    notifyListeners();
  }

  void updateGoal(int goal) {
    _goal = goal;
    CacheUtil().updateGoal(goal);
    notifyListeners();
  }

  Locale _local = const Locale("en");
  Locale get local => _local;
  void updateLanguage(String code) {
    _local = Locale(code);
    notifyListeners();
    delayedFunction();
  }

  Future<void> delayedFunction() async {

    // 使用 Future.delayed 实现异步延迟
    await Future.delayed(const Duration(milliseconds: 100));

    CacheUtil().getReminders().then((value) {
      for (var element in value) {
        NotificationUtil().appendReminder(element);
      }
    });
  }
}