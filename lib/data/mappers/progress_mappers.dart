import '../../features/lesson/models/lesson_result.dart';
import '../../features/puzzle/models/puzzle.dart';
import '../models/stored_progress.dart';

StoredAttempt storedAttemptFrom({
  required Puzzle puzzle,
  required bool isCorrect,
  required int xpEarned,
  DateTime? attemptedAt,
}) {
  return StoredAttempt(
    puzzleId: puzzle.id,
    puzzleType: puzzle.type.name,
    difficulty: puzzle.difficulty.name,
    isCorrect: isCorrect,
    xpEarned: xpEarned,
    attemptedAt: attemptedAt ?? DateTime.now(),
  );
}

StoredLessonResult storedLessonResultFrom(
  LessonResult result, {
  DateTime? completedAt,
}) {
  return StoredLessonResult(
    correctCount: result.correctCount,
    totalCount: result.totalCount,
    xpEarned: result.xpEarned,
    completedAt: completedAt ?? DateTime.now(),
  );
}
