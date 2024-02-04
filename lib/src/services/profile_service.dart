
import 'package:flutter/cupertino.dart';

class ProfileLogic extends ChangeNotifier {
  bool _isRefresh = false;
  bool get isRefresh => _isRefresh;
  refreshUI() {
    _isRefresh = !_isRefresh;
    notifyListeners();
  }
}