
import 'package:flutter/cupertino.dart';
import 'package:h2o_keeper/src/models/profile_item.dart';

class TipLogic extends ChangeNotifier {
  TipLogic(ProfileTipItem item) {
    _item = item;
  }
  ProfileTipItem _item = ProfileTipItem.how;
  ProfileTipItem get item => _item;
}