import 'package:flutter/foundation.dart';

import '../level/level_calculator.dart';
import '../level/models/level_up.dart';

class XpController extends ChangeNotifier {
  int _total = 0;

  int get total => _total;

  int get level => LevelCalculator.levelFor(_total);

  LevelUp? add(int amount) {
    if (amount <= 0) return null;

    final levelBefore = LevelCalculator.levelFor(_total);
    _total += amount;
    final levelAfter = LevelCalculator.levelFor(_total);
    notifyListeners();

    if (levelAfter > levelBefore) {
      return LevelUp(fromLevel: levelBefore, toLevel: levelAfter);
    }
    return null;
  }
}
