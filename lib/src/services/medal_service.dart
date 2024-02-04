
import 'package:flutter/cupertino.dart';
import 'package:h2o_keeper/src/models/medal_item.dart';
import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:h2o_keeper/src/utils/cache_util.dart';

class MedalLogic extends ChangeNotifier {
  MedalLogic() {
    CacheUtil().getRecords().then((value) => updateRecord(value));
  }
  List<RecordModel> _records = [];
  List<RecordModel> get records => _records;
  void updateRecord(List<RecordModel> recors) {
    _records = recors;
    notifyListeners();
  }

  List<MedalKeep> get keepModels => MedalKeep.values;
  List<MedalGoal> get goalModels => MedalGoal.values;
}
