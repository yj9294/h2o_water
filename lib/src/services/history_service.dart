
import 'package:flutter/cupertino.dart';
import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:h2o_keeper/src/utils/cache_util.dart';

class HistoryLogic extends ChangeNotifier {
  HistoryLogic() {
    CacheUtil().getRecords().then((value) => updateRecords(value));
  }
  List<RecordModel> _records = [];
  List<RecordModel> get records => _records;
  void updateRecords(List<RecordModel> recors) {
    _records = recors;
    notifyListeners();
  }

  List<List<RecordModel>> get recordsModel {
    if (_records.isEmpty) {
      return[];
    }
    return _records.fold([[]], (previousValue, element) {
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
  }
}