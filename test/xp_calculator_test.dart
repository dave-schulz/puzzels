import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/puzzle/models/puzzle_difficulty.dart';
import 'package:brainy/features/xp/xp_calculator.dart';
import 'package:brainy/features/xp/xp_controller.dart';

void main() {
  group('XpCalculator', () {
    test('awards more XP for harder puzzles', () {
      expect(XpCalculator.amountFor(PuzzleDifficulty.easy), 10);
      expect(XpCalculator.amountFor(PuzzleDifficulty.medium), 20);
      expect(XpCalculator.amountFor(PuzzleDifficulty.hard), 30);
    });

    test('reward includes difficulty', () {
      final reward = XpCalculator.rewardFor(PuzzleDifficulty.medium);

      expect(reward.amount, 20);
      expect(reward.difficulty, PuzzleDifficulty.medium);
    });
  });

  group('XpController', () {
    test('adds XP and notifies listeners', () {
      final controller = XpController();
      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.add(20);
      controller.add(10);

      expect(controller.total, 30);
      expect(notifications, 2);
    });

    test('ignores non-positive amounts', () {
      final controller = XpController();

      controller.add(0);
      controller.add(-5);

      expect(controller.total, 0);
    });
  });
}
