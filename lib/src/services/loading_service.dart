
import 'dart:async';

import 'package:flutter/material.dart';

class LoadingLogic extends ChangeNotifier{

  LoadingLogic() {
    startLoading();
  }

  double _progress = 0.0;
  Timer? timer;
  bool get isLoading => _progress < 1.0;
  double get progress => _progress;

  void startLoading() {
    var duration = 3.0;
    updateProgress(0.0);
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      updateProgress(_progress + 0.01 / duration);
      if (_progress >= 1.0) {
        updateProgress(1.0);
        timer.cancel();
      }
    });
  }

  void updateProgress(double progress) {
    _progress = progress;
    notifyListeners();
  }
  
}