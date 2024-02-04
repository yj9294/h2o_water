
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:h2o_keeper/src/models/gad_position.dart';
import 'package:h2o_keeper/src/utils/gad_util.dart';

class LoadingLogic extends ChangeNotifier{

  LoadingLogic() {
    startLoading();
  }

  double _progress = 0.0;
  Timer? timer;
  bool get isLoading => _progress < 1.0;
  double get progress => _progress;

  void startLoading() {
    GADUtil().load(GADPosition.open);
    var duration = 3.0;
    updateProgress(0.0);
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      final pro =  _progress + 0.01 / duration;
      if (pro >= 1.0) {
        timer.cancel();
        GADUtil().show(GADPosition.open, closeHandler: () => updateProgress(1.0));
      } else {
        updateProgress(pro);
      }
    });
  }

  void updateProgress(double progress) {
    _progress = progress;
    notifyListeners();
  }
  
}