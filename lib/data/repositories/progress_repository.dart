class StoredUserProgress {
  const StoredUserProgress({
    required this.userId,
    required this.totalXp,
    required this.streak,
    required this.lastPlayDate,
    required this.updatedAt,
  });

  final String userId;
  final int totalXp;
  final int streak;
  final DateTime? lastPlayDate;
  final DateTime updatedAt;
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

abstract class ProgressRepository {
  Future<StoredUserProgress?> getProgress(String userId);

  Future<void> saveProgress({
    required String userId,
    required int totalXp,
    required int streak,
    DateTime? lastPlayDate,
  });

  Future<void> recordAttempt({
    required String userId,
    required StoredAttempt attempt,
  });

  Future<void> recordLessonResult({
    required String userId,
    required StoredLessonResult result,
  });
}
