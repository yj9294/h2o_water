import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h2o_keeper/src/models/gad_config.dart';
import 'package:h2o_keeper/src/models/gad_limit.dart';
import 'package:h2o_keeper/src/models/gad_load_model.dart';
import 'package:h2o_keeper/src/models/gad_model.dart';
import 'package:h2o_keeper/src/models/gad_position.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GADUtil {
  static final _shared = GADUtil._internal();

  factory GADUtil() {
    return _shared;
  }

  GADUtil._internal() {
    Timer.periodic(const Duration(milliseconds: 5), (timer) {
      for (var element in adLoads) {
        element.loadedList = List<GADModel>.from(element.loadedList
            .where((item) => item.loadedDate?.isExpired() == false));
      }
    });
  }

  // 原生广告展示时间
  DateTime homeImpressionDate = DateTime.utc(2020);

  // 原生广告展示时间
  DateTime tabImpressionDate = DateTime.utc(2020);

  // 构造加载模型
  late List<GADLoadModel> adLoads =
      List<GADLoadModel>.from(GADPosition.values.map((e) => GADLoadModel(e)));

  Future<GADConfig> getConfig() async {
    var prefs = await SharedPreferences.getInstance();
    var configString = prefs.getString('config') ?? "{}";
    return GADConfig.fromJson(configString);
  }

  Future<void> setConfig(GADConfig config) async {
    var prefs = await SharedPreferences.getInstance();
    var ret = await prefs.setString("config", jsonEncode(config.toJson()));
    debugPrint("[Config] config 缓存成功？ ret = $ret");
  }

  Future<GADLimit> getLimit() async {
    var prefs = await SharedPreferences.getInstance();
    return GADLimit.fromJsonString(prefs.getString('limit') ?? "{}");
  }

  Future<void> setLimit(GADLimit limit) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('limit', limit.toJsonString());
  }
}

extension GADUtilExt on GADUtil {
  // 是否超限
  Future<bool> isADLimited() async {
    var config = await getConfig();
    var limit = await getLimit();
    if (limit.date?.isToday() == true) {
      return (limit.showTimes ?? 0) >= (config.showTimes ?? 0) ||
          (limit.clickTimes ?? 0) >= (config.clickTimes ?? 0);
    }
    return false;
  }

  // 是否加载完成
  bool isLoadedAD(GADPosition position) {
    final adLoad =
        adLoads.where((element) => element.position == position).first;
    return adLoad.loadCompletion;
  }

  // 是否需要清理点击缓存
  Future<bool> isNeedCleanLimit() async {
    var limit = await getLimit();
    return limit.date?.isToday() != true;
  }

  // 清理点击缓存
  void cleanLimit() {
    setLimit(GADLimit(showTimes: 0, clickTimes: 0, date: DateTime.now()));
  }

  // 更改缓存
  Future<void> updateLimit(GADLimitPosition p) async {
    var limit = await getLimit();
    var isLimited = await isADLimited();
    if (isLimited) {
      debugPrint("[AD] limited ad");
      return;
    }
    if (p == GADLimitPosition.show) {
      limit.showTimes = (limit.showTimes ?? 0) + 1;
      limit.date = DateTime.now();
      setLimit(limit);
      debugPrint("[AD] [Limited] [show] ${limit.showTimes}");
    }
    if (p == GADLimitPosition.click) {
      limit.clickTimes = (limit.clickTimes ?? 0) + 1;
      limit.date = DateTime.now();
      setLimit(limit);
      debugPrint("[AD] [Limited] [click] ${limit.clickTimes}");
    }
  }

  Future<GADModel?> load(GADPosition position) async {
    Completer<GADModel?> completer = Completer();
    var load = adLoads.where((element) => element.position == position).first;
    load.loadCompletion = false;
    load.beginADWaterFall().then((value) {
      load.loadCompletion = true;
      // 发出加载完成事件通知
      // EventBusUtil().eventBus.fire(value);
      completer.complete(value);
    });
    return completer.future;
  }

  Future<void> show(GADPosition position,
      {GADCloseHandler? closeHandler}) async {
    // 获取当前加载
    GADLoadModel loadModel = List<GADLoadModel>.from(
        adLoads.where((element) => element.position == position)).first;

    final isADLimit = await isADLimited();

    if (loadModel.loadedList.isNotEmpty && !isADLimit) {
      // 插屏
      GADModel ad = loadModel.loadedList.first;

      // if (position == GADPosition.interstitial) {
      //   AppUtil().isPresentedAD = true;
      // }
      // 回调
      ad.callback = GADModelCallback(impressionHandler: () {
        // 缓存展示
        updateLimit(GADLimitPosition.show);
        // 展示
        appear(position);
        // 预加载
        if (position == GADPosition.native) {
          load(position);
        }
      }, clickHandler: () {
        // 缓存点击
        updateLimit(GADLimitPosition.click);
      }, closeHandler: () {
        // 消失
        disAppear(position);
        if (closeHandler != null) {
          closeHandler();
        }
        // if (position == GADPosition.interstitial) {
        //   AppUtil().isPresentedAD = false;
        // }
        load(position);
      }, errorHandler: () {
        // 错误展示
        if (closeHandler != null) {
          closeHandler();
        }
        clean(position);
        // if (position == GADPosition.interstitial) {
        //   AppUtil().isPresentedAD = false;
        // }
      });
      ad.present();
    } else {
      clean(GADPosition.native);
      clean(GADPosition.interstitial);
      if (closeHandler != null) {
        closeHandler();
      }
    }
  }

  void appear(GADPosition position) {
    adLoads.where((element) => element.position == position).first.appear();
  }

  Future<void> disAppear(GADPosition position) async {
    adLoads.where((element) => element.position == position).first.disAppear();
  }

  void clean(GADPosition position) {
    adLoads.where((element) => element.position == position).first.clean();
  }

  Future<void> requestConfig() async {
    try {
      var config = await getConfig();
      if (config.showTimes == null) {
        var data = await rootBundle.loadString('assets/data/config.json');
        config = GADConfig.fromJson(data);
        setConfig(config);
        debugPrint("[Config] :${jsonEncode(config.toJson())}");
      } else {
        debugPrint("[Config] :${jsonEncode(config.toJson())}");
      }
    } catch (e) {
      debugPrint("[Config] err:$e");
    }

    /// 广告配置是否是当天的
    isNeedCleanLimit().then((isNeed) {
      if (isNeed) {
        cleanLimit();
      }
    });
  }
}

extension DateTimeExt on DateTime {
  bool isExpired() {
    var difference = DateTime.now().difference(this);
    return difference.inSeconds > 3000;
  }

  bool isToday() {
    return day == DateTime.now().day;
  }
}
