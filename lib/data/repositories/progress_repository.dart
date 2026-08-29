import '../models/stored_daily_challenge.dart';
import '../models/stored_progress.dart';
import '../models/stored_user.dart';

/// Local and remote progress storage share this interface.
/// Override [progressRepositoryProvider] in main to swap implementations.
abstract class ProgressRepository {
  Future<StoredUser?> getUser(String userId);

  Future<StoredUserProgress?> getProgress(String userId);

  Future<void> saveProgress({
    required String userId,
    required int totalXp,
    required int streak,
    DateTime? lastPlayDate,
    required int sequenceSkill,
    required int logicSkill,
    required int patternSkill,
  });

  Future<StoredDailyChallengeCompletion?> getDailyChallengeCompletion({
    required String userId,
    required String challengeDate,
  });

  Future<void> recordDailyChallengeCompletion({
    required String userId,
    required StoredDailyChallengeCompletion completion,
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
