import 'package:drift/drift.dart';

import '../local/app_database.dart';
import '../models/stored_progress.dart';
import '../models/stored_user.dart';
import 'progress_repository.dart';

class LocalProgressRepository implements ProgressRepository {
  LocalProgressRepository(this._database);

  final AppDatabase _database;

  @override
  Future<StoredUser?> getUser(String userId) async {
    final row = await (_database.select(_database.users)
          ..where((user) => user.id.equals(userId)))
        .getSingleOrNull();

    if (row == null) return null;

    return StoredUser(id: row.id, displayName: row.displayName);
  }

  @override
  Future<StoredUserProgress?> getProgress(String userId) async {
    final row = await (_database.select(_database.userProgress)
          ..where((progress) => progress.userId.equals(userId)))
        .getSingleOrNull();

    if (row == null) return null;

    return StoredUserProgress(
      userId: row.userId,
      totalXp: row.totalXp,
      streak: row.streak,
      lastPlayDate: row.lastPlayDate,
      updatedAt: row.updatedAt,
      sequenceSkill: row.sequenceSkill,
      logicSkill: row.logicSkill,
      patternSkill: row.patternSkill,
    );
  }

  @override
  Future<void> saveProgress({
    required String userId,
    required int totalXp,
    required int streak,
    DateTime? lastPlayDate,
    required int sequenceSkill,
    required int logicSkill,
    required int patternSkill,
  }) async {
    await _database.into(_database.userProgress).insertOnConflictUpdate(
          UserProgressCompanion(
            userId: Value(userId),
            totalXp: Value(totalXp),
            streak: Value(streak),
            lastPlayDate: Value(lastPlayDate),
            sequenceSkill: Value(sequenceSkill),
            logicSkill: Value(logicSkill),
            patternSkill: Value(patternSkill),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<void> recordAttempt({
    required String userId,
    required StoredAttempt attempt,
  }) async {
    await _database.into(_database.attempts).insert(
          AttemptsCompanion.insert(
            userId: userId,
            puzzleId: attempt.puzzleId,
            puzzleType: attempt.puzzleType,
            difficulty: attempt.difficulty,
            isCorrect: attempt.isCorrect,
            xpEarned: Value(attempt.xpEarned),
            attemptedAt: attempt.attemptedAt,
          ),
        );
  }

  @override
  Future<void> recordLessonResult({
    required String userId,
    required StoredLessonResult result,
  }) async {
    await _database.into(_database.lessonResults).insert(
          LessonResultsCompanion.insert(
            userId: userId,
            correctCount: result.correctCount,
            totalCount: result.totalCount,
            xpEarned: result.xpEarned,
            completedAt: result.completedAt,
          ),
        );
  }
}
