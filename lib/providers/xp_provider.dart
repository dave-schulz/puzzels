import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/level/level_calculator.dart';
import '../features/level/models/level_up.dart';
import 'progress_persistence.dart';

class XpNotifier extends Notifier<int> {
  @override
  int build() => 0;

  int get level => LevelCalculator.levelFor(state);

  void restore(int totalXp) {
    state = totalXp;
  }

  LevelUp? add(int amount) {
    if (amount <= 0) return null;

    final levelBefore = LevelCalculator.levelFor(state);
    state += amount;
    final levelAfter = LevelCalculator.levelFor(state);

    persistXpProgress(ref, state);

    if (levelAfter > levelBefore) {
      return LevelUp(fromLevel: levelBefore, toLevel: levelAfter);
    }
    return null;
  }
}

final xpProvider = NotifierProvider<XpNotifier, int>(XpNotifier.new);

final totalXpProvider = Provider<int>((ref) => ref.watch(xpProvider));

final levelProvider = Provider<int>((ref) {
  return LevelCalculator.levelFor(ref.watch(xpProvider));
});
