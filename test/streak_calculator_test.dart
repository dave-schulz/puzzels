import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/streak/streak_calculator.dart';
import 'package:brainy/features/streak/streak_controller.dart';

void main() {
  final today = DateTime(2026, 8, 29);
  final yesterday = DateTime(2026, 8, 28);
  final twoDaysAgo = DateTime(2026, 8, 27);

  group('StreakCalculator', () {
    test('first play starts streak at 1', () {
      final update = StreakCalculator.recordPlay(
        currentStreak: 0,
        lastPlayDate: null,
        now: today,
      );

      expect(update.streak, 1);
    });

    test('playing again today keeps streak', () {
      final update = StreakCalculator.recordPlay(
        currentStreak: 5,
        lastPlayDate: today,
        now: today,
      );

      expect(update.streak, 5);
    });

    test('playing on consecutive days increases streak', () {
      final update = StreakCalculator.recordPlay(
        currentStreak: 5,
        lastPlayDate: yesterday,
        now: today,
      );

      expect(update.streak, 6);
    });

    test('missing a day resets streak', () {
      final update = StreakCalculator.recordPlay(
        currentStreak: 7,
        lastPlayDate: twoDaysAgo,
        now: today,
      );

      expect(update.streak, 1);
    });

    test('playedToday and playedYesterday helpers', () {
      expect(
        StreakCalculator.playedToday(
          lastPlayDate: today,
          now: today,
        ),
        isTrue,
      );
      expect(
        StreakCalculator.playedYesterday(
          lastPlayDate: yesterday,
          now: today,
        ),
        isTrue,
      );
    });
  });

  group('StreakController', () {
    test('records lesson completion', () {
      final controller = StreakController();

      controller.recordLessonCompleted(today);
      controller.recordLessonCompleted(today);

      expect(controller.streak, 1);
      expect(controller.playedToday(today), isTrue);
    });
  });
}
