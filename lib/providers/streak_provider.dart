import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/streak/streak_calculator.dart';
import 'progress_persistence.dart';

class StreakData {
  const StreakData({
    required this.streak,
    this.lastPlayDate,
  });

  final int streak;
  final DateTime? lastPlayDate;
}

class StreakNotifier extends Notifier<StreakData> {
  @override
  StreakData build() => const StreakData(streak: 0);

  void restore({
    required int streak,
    DateTime? lastPlayDate,
  }) {
    state = StreakData(streak: streak, lastPlayDate: lastPlayDate);
  }

  bool playedToday([DateTime? now]) {
    return StreakCalculator.playedToday(
      lastPlayDate: state.lastPlayDate,
      now: now ?? DateTime.now(),
    );
  }

  void recordLessonCompleted([DateTime? now]) {
    final update = StreakCalculator.recordPlay(
      currentStreak: state.streak,
      lastPlayDate: state.lastPlayDate,
      now: now ?? DateTime.now(),
    );

    state = StreakData(
      streak: update.streak,
      lastPlayDate: update.lastPlayDate,
    );

    Future.microtask(() => persistStreakProgress(ref, state));
  }
}

final streakProvider = NotifierProvider<StreakNotifier, StreakData>(
  StreakNotifier.new,
);

final streakCountProvider = Provider<int>((ref) {
  return ref.watch(streakProvider).streak;
});
