import 'package:flutter/foundation.dart';

class XpController extends ChangeNotifier {
  int _total = 0;

  int get total => _total;

  void add(int amount) {
    if (amount <= 0) return;
    _total += amount;
    notifyListeners();
  }
}
