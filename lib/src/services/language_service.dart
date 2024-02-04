
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:h2o_keeper/src/models/language_item.dart';
import 'package:h2o_keeper/src/utils/cache_util.dart';

class LanguageLogic extends ChangeNotifier {
  LanguageLogic() {
    CacheUtil().getLanguage().then((value) {
      LanguageItem item = EnumToString.fromString(LanguageItem.values, value) ?? LanguageItem.english;
      updateItem(item);
    });
    return;
  }

  List<LanguageItem> get items => LanguageItem.values;
  LanguageItem _item = LanguageItem.english;
  LanguageItem get item => _item;
  void updateItem(LanguageItem item) {
    _item = item;
    CacheUtil().updateLanguage(item.name);
    notifyListeners();
  }
}