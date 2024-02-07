
import 'package:flutter/cupertino.dart';
import 'package:h2o_keeper/src/utils/cache_util.dart';

class GoalLogic extends ChangeNotifier {

  GoalLogic() {
    CacheUtil().getGoal().then((value) => updateGoal(value));
  }

  // 总目标
  int _goal = 0;
  int get goal => _goal;

  double get progress {
    return _goal.toDouble() / 4000.0;
  }

  void updateGoal(int goal) {
    final s = goal ~/ 100;
    _goal = s * 100;
    notifyListeners();
  }

  void goalAdd() {
    int s = goal + 100;
    _goal = s > 4000 ? 4000 : s;
    notifyListeners();
  }

  void goalDecrease() {
    int s = goal -100;
    _goal = s <= 100 ? 100 : s;
    notifyListeners();
  }

}