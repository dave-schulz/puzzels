class StoredUserProgress {
  const StoredUserProgress({
    required this.userId,
    required this.totalXp,
    required this.streak,
    required this.lastPlayDate,
    required this.updatedAt,
    required this.sequenceSkill,
    required this.logicSkill,
    required this.patternSkill,
  });

  final String userId;
  final int totalXp;
  final int streak;
  final DateTime? lastPlayDate;
  final DateTime updatedAt;
  final int sequenceSkill;
  final int logicSkill;
  final int patternSkill;
}

class StoredAttempt {
  const StoredAttempt({
    required this.puzzleId,
    required this.puzzleType,
    required this.difficulty,
    required this.isCorrect,
    required this.xpEarned,
    required this.attemptedAt,
  });

  final String puzzleId;
  final String puzzleType;
  final String difficulty;
  final bool isCorrect;
  final int xpEarned;
  final DateTime attemptedAt;
}

class StoredLessonResult {
  const StoredLessonResult({
    required this.correctCount,
    required this.totalCount,
    required this.xpEarned,
    required this.completedAt,
  });

  final int correctCount;
  final int totalCount;
  final int xpEarned;
  final DateTime completedAt;
}
