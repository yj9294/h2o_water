import 'dart:async';

import 'package:flutter/material.dart';
import 'package:h2o_keeper/src/models/gad_position.dart';
import 'package:h2o_keeper/src/services/index.dart';
import 'package:h2o_keeper/src/utils/gad_util.dart';
import 'package:provider/provider.dart';

class LoadingLogic extends ChangeNotifier {
  LoadingLogic();

  double _progress = 0.0;
  Timer? timer;
  bool get isLoading => _progress < 1.0;
  double get progress => _progress;

  double _duration = 13.0;
  double get duration => _duration;

  void startLoading(BuildContext context) {
    GADUtil().load(GADPosition.open);
    GADUtil().load(GADPosition.native);
    GADUtil().load(GADPosition.interstitial);
    updateDuration(13.0);
    updateProgress(0.0, context);
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      final pro = _progress + 0.01 / duration;
      debugPrint("[ad] $progress");
      if (pro >= 1.0) {
        timer.cancel();
        GADUtil().show(GADPosition.open,
            closeHandler: () => updateProgress(1.0, context));
      } else {
        updateProgress(pro, context);
        if (GADUtil().isLoadedAD(GADPosition.open) && progress > 0.3) {
          updateDuration(0.2);
        }
      }
    });
  }

  void updateProgress(double progress, BuildContext context) {
    _progress = progress;
    notifyListeners();

    if (!isLoading) {
      loadNativeAD(context);
    }
  }

  void updateDuration(double duration) {
    _duration = duration;
    notifyListeners();
  }

  loadNativeAD(BuildContext context) async {
    // 清空
    final homeLogic = context.read<HomeLogic>();
    GADUtil().disAppear(GADPosition.native);
    homeLogic.updateADModel(null);

    // 设置 impression
    final adModel = await GADUtil().load(GADPosition.native);
    if (adModel == null) {
      return;
    }
    await GADUtil().show(GADPosition.native);
    homeLogic.updateADModel(adModel);
  }
}
