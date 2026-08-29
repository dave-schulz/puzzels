import 'models/level_progress.dart';

abstract final class LevelCalculator {
  static const thresholds = <int>[0, 100, 250, 500];

  static int levelFor(int totalXp) {
    var level = 1;
    for (var i = 1; i < thresholds.length; i++) {
      if (totalXp >= thresholds[i]) {
        level = i + 1;
      }
    }
    return level;
  }

  static LevelProgress progressFor(int totalXp) {
    final level = levelFor(totalXp);
    final currentThreshold = thresholds[level - 1];
    final isMaxLevel = level >= thresholds.length;
    final nextThreshold = isMaxLevel ? currentThreshold : thresholds[level];

    final xpIntoLevel = totalXp - currentThreshold;
    final xpNeededForNext = isMaxLevel ? 0 : nextThreshold - currentThreshold;
    final progress = isMaxLevel
        ? 1
        : xpNeededForNext == 0
            ? 0
            : xpIntoLevel / xpNeededForNext;

    return LevelProgress(
      level: level,
      totalXp: totalXp,
      xpIntoLevel: xpIntoLevel,
      xpNeededForNext: xpNeededForNext,
      progress: progress.clamp(0, 1).toDouble(),
      isMaxLevel: isMaxLevel,
    );
  }
}
