import 'package:flutter/foundation.dart';

import 'streak_calculator.dart';

class StreakController extends ChangeNotifier {
  int _streak = 0;
  DateTime? _lastPlayDate;

  int get streak => _streak;

  DateTime? get lastPlayDate => _lastPlayDate;

  bool playedToday([DateTime? now]) {
    return StreakCalculator.playedToday(
      lastPlayDate: _lastPlayDate,
      now: now ?? DateTime.now(),
    );
  }

  void recordLessonCompleted([DateTime? now]) {
    final update = StreakCalculator.recordPlay(
      currentStreak: _streak,
      lastPlayDate: _lastPlayDate,
      now: now ?? DateTime.now(),
    );
    _streak = update.streak;
    _lastPlayDate = update.lastPlayDate;
    notifyListeners();
  }
}
