import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:h2o_keeper/src/models/gad_config.dart';
import 'package:h2o_keeper/src/models/gad_model.dart';
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
      LanguageItem item = EnumToString.fromString(LanguageItem.values, value) ??
          LanguageItem.english;
      updateLanguage(item.languageCode);
    });
  }

  // ad mobile
  Map<TabbarItem, DateTime> nativeImpDate = {};
  GADNativeModel? _adModel;
  GADNativeModel get adModel =>
      _adModel ?? GADNativeModel(GADConfigItem(0, ""));
  bool get hasNativeAD => adModel.ad != null;
  void updateADModel(GADModel? model) {
    if (model == null) {
      _adModel = null;
      notifyListeners();
      return;
    }

    final adModel = model as GADNativeModel;

    if (adModel.ad == null) {
      _adModel = null;
      notifyListeners();
      return;
    }
    DateTime? impD = nativeImpDate[item];
    if (impD == null || DateTime.now().difference(impD).inSeconds > 10) {
      nativeImpDate[item] = DateTime.now();
      _adModel = adModel;
      notifyListeners();
    } else {
      debugPrint("[AD] $item 位原生广告10s间隔 或者是预加载的数据");
    }
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

  // 用于 插屏广告关闭时候 系统默认是进入前台
  bool _showInterestitalAD = false;
  bool get showInterestitalAD => _showInterestitalAD;
  updateShowInteresttitalAD(bool isShow) {
    _showInterestitalAD = isShow;
    notifyListeners();
  }

  // 进入后台
  bool _isEnterBackground = false;
  bool get isEnterBackground => _isEnterBackground;
  updateEnterBackground(bool enter) {
    _isEnterBackground = enter;
  }
}
