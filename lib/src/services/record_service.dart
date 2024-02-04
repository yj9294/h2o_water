import 'package:flutter/cupertino.dart';
import 'package:h2o_keeper/src/models/record_model.dart';
import 'package:h2o_keeper/src/screens/tip_screen.dart';
import 'package:h2o_keeper/src/utils/cache_util.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class RecordLogic extends ChangeNotifier {
  RecordLogic() {
    CacheUtil().getGoal().then((value) => updateGoal(value));
  }
  int _goal = 0;
  int get goal => _goal;
  void updateGoal(int goal) {
    _goal = goal;
    notifyListeners();
  }

  RecordItem _item = RecordItem.water;
  RecordItem get item => _item;
  int get ml {
    final mlString = _mlController.text;
    return int.parse(mlString);
  }

  RecordModel get recordModel {
    return RecordModel(id: const Uuid().v4(),day: DateTime.now().dayString, time: DateTime.now().timeString, item: _item, name: _nameController.text, ml: ml, goal: goal);
  }

  bool get isMLSure {
    final text = _mlController.text;
    if (text.isEmpty) {
      return false;
    } else {
      return text.isNumeric;
    }
  }

  String _name = RecordItem.water.title;
  String get name => _name;

  final List<Color> colors = [HexColor("#58C4C9"),HexColor("#F6AD42"), HexColor("#79C6EE"), HexColor("#F06358"), HexColor("#F29B82"), HexColor("#6FCC6B")];

  final _mlController = TextEditingController(text: "200");
  TextEditingController get mlController => _mlController;

  final _nameController = TextEditingController(text: "Custom");
  TextEditingController get nameController => _nameController;

  void updateItem(RecordItem item) {
    _item = item;
    _name = item.title;
    _mlController.text = "200";
    _nameController.text = item.title;
    notifyListeners();
  }

  void updateML(String ml) {
    _mlController.text = ml;
    notifyListeners();
  }

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

}

extension DateExt on DateTime {
  String get dayString {
    final dateFormat = DateFormat("yyyy-MM-dd");
    return dateFormat.format(DateTime.now());
  }

  String get timeString {
    final dateFormat = DateFormat("HH:mm");
    return dateFormat.format(DateTime.now());
  }
}