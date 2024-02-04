
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h2o_keeper/src/utils/cache_util.dart';
import 'package:h2o_keeper/src/utils/notification_util.dart';

class ReminderLogic extends ChangeNotifier {

  ReminderLogic() {
    CacheUtil().getReminders().then((value) => updateItems(value));
    CacheUtil().getWeekMode().then((value) => updateWeekMode(value));
  }

  List<String> _items = [];
  List<String> get items => _items;
  void updateItems(List<String> items) {
    _items = items;
    notifyListeners();
    for (var element in _items) {
      NotificationUtil().appendReminder(element);
    }
  }
  void appendItem(String item) {
    if (_items.contains(item)) {
      return;
    }
    _items.add(item);
    _items.sort((a, b) => a.compareTo(b));
    notifyListeners();
    CacheUtil().appendReminder(item);
    NotificationUtil().appendReminder(item);
  }
  void deleteItem(String item) {
    _items.removeWhere((element) => element == item);
    notifyListeners();
    CacheUtil().removereminder(item);
    NotificationUtil().removeReminder(item);
  }

  bool _weekMode = false;
  bool get weekMode => _weekMode;
  void updateWeekMode(bool mode) {
    _weekMode = mode;
    CacheUtil().updateWeekMode(mode);
    notifyListeners();

    for (var element in _items) {
      NotificationUtil().appendReminder(element);
    }
  }

  bool _showTimeView = false;
  bool get showTimeView => _showTimeView;
  void updateShowTimeView(bool isShow) {
    _showTimeView = isShow;
    notifyListeners();
    if (isShow) {
      updateHour(0);
      updateMintue(0);
    }
  } 

  int _hour = 0;
  int get hour => _hour;
  void updateHour(int hour) {
    _hour = hour;
    notifyListeners();
  }

  int _mintue = 0;
  int get mintue => _mintue;
  void updateMintue(int mintue) {
    _mintue = mintue;
    notifyListeners();
  }


  void addNewReminder() {
    final hourStr = _hour.toString().padLeft(2, '0');
    final minStr = _mintue.toString().padLeft(2, '0');
    final reminder = "$hourStr:$minStr";
    appendItem(reminder);
  }

}