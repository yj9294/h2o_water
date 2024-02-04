
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/models/record_item.dart';
import 'package:json_annotation/json_annotation.dart';
part 'record_model.g.dart'; // 自动生成的文件名

@JsonSerializable()
class RecordModel {
  String id = "";
  String day = "";
  String time = "";
  RecordItem item = RecordItem.water;
  String name = "";
  int ml = 0;
  int goal = 0;

  RecordModel({required this.id, required this.day, required this.time, required this.item, required this.name, required this.ml, required this.goal});

  factory RecordModel.fromJson(Map<String, dynamic> json) => _$RecordModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecordModelToJson(this);

}

enum RecordItem {
  water, drinks, coffee, tea, milk, customization
}

extension RecordItemExt on RecordItem {
  String get name => describeEnum(this);
  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(indexOfDot != -1 && indexOfDot < description.length - 1);
    return description.substring(indexOfDot + 1);
  }

  String get title {
    return name.capitalize();
  }

  String get icon {
    return name;
  }

  String get localTitle {
    switch (this) {
      case RecordItem.water:
      return S.current.water;
      case RecordItem.coffee:
      return S.current.coffee;
      case RecordItem.drinks:
      return S.current.drinks;
      case RecordItem.tea:
      return S.current.tea;
      case RecordItem.milk:
      return S.current.milk;
      case RecordItem.customization:
      return S.current.customization;
    }
  }
}