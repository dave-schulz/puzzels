class LevelProgress {
  const LevelProgress({
    required this.level,
    required this.totalXp,
    required this.xpIntoLevel,
    required this.xpNeededForNext,
    required this.progress,
    required this.isMaxLevel,
  });

  final int level;
  final int totalXp;
  final int xpIntoLevel;
  final int xpNeededForNext;
  final double progress;
  final bool isMaxLevel;
}
