import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/level/level_calculator.dart';

void main() {
  group('LevelCalculator', () {
    test('maps XP to level thresholds', () {
      expect(LevelCalculator.levelFor(0), 1);
      expect(LevelCalculator.levelFor(99), 1);
      expect(LevelCalculator.levelFor(100), 2);
      expect(LevelCalculator.levelFor(249), 2);
      expect(LevelCalculator.levelFor(250), 3);
      expect(LevelCalculator.levelFor(499), 3);
      expect(LevelCalculator.levelFor(500), 4);
      expect(LevelCalculator.levelFor(999), 4);
    });

    test('calculates progress within level', () {
      final progress = LevelCalculator.progressFor(150);

      expect(progress.level, 2);
      expect(progress.xpIntoLevel, 50);
      expect(progress.xpNeededForNext, 150);
      expect(progress.progress, closeTo(50 / 150, 0.001));
      expect(progress.isMaxLevel, false);
    });

    test('max level shows full progress', () {
      final progress = LevelCalculator.progressFor(600);

      expect(progress.level, 4);
      expect(progress.isMaxLevel, true);
      expect(progress.progress, 1);
    });
  });
}
