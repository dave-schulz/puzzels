import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/mappers/progress_mappers.dart';
import '../features/lesson/models/lesson.dart';
import '../features/lesson/models/lesson_result.dart';
import '../features/lesson/models/lesson_session_state.dart';
import '../features/level/models/level_up.dart';
import '../features/puzzle/models/puzzle.dart';
import '../features/xp/xp_calculator.dart';
import 'database_provider.dart';
import 'puzzle_provider.dart';
import 'skills_provider.dart';
import 'streak_provider.dart';
import 'user_provider.dart';
import 'xp_provider.dart';

export '../features/lesson/models/lesson_session_state.dart';

class LessonSessionNotifier extends Notifier<LessonSessionState?> {
  @override
  LessonSessionState? build() => null;

  void start(Lesson lesson) {
    state = LessonSessionState(lesson: lesson);
  }

  void clear() {
    state = null;
  }

  LevelUp? selectAnswer(int index) {
    final session = state;
    if (session == null || session.isAnswered) return null;

    final puzzle = session.currentPuzzle;

    if (index == puzzle.correctIndex) {
      final reward = XpCalculator.rewardFor(puzzle.difficulty);
      final levelUp = ref.read(xpProvider.notifier).add(reward.amount);

      ref.read(skillsProvider.notifier).recordAttempt(
            puzzle,
            isCorrect: true,
          );

      unawaited(_recordAttempt(
        puzzle: puzzle,
        isCorrect: true,
        xpEarned: reward.amount,
      ));

      state = session.copyWith(
        selectedIndex: index,
        result: PuzzleAnswerResult.correct,
        sessionXpEarned: session.sessionXpEarned + reward.amount,
        xpGainAmount: reward.amount,
        xpAnimationKey: session.xpAnimationKey + 1,
      );
      return levelUp;
    }

    ref.read(skillsProvider.notifier).recordAttempt(
          puzzle,
          isCorrect: false,
        );

    unawaited(_recordAttempt(
      puzzle: puzzle,
      isCorrect: false,
      xpEarned: 0,
    ));

    state = session.copyWith(
      selectedIndex: index,
      result: PuzzleAnswerResult.incorrect,
      hearts: (session.hearts - 1).clamp(0, 5),
    );
    return null;
  }

  LessonResult? continueAfterFeedback() {
    final session = state;
    if (session == null || !session.isAnswered) return null;

    if (session.result == PuzzleAnswerResult.correct) {
      final updatedCorrectCount = session.correctCount + 1;

      if (session.isLastPuzzle) {
        ref.read(streakProvider.notifier).recordLessonCompleted();
        final result = LessonResult(
          correctCount: updatedCorrectCount,
          totalCount: session.lesson.puzzleCount,
          xpEarned: session.sessionXpEarned,
        );
        unawaited(_recordLessonResult(result));
        state = null;
        return result;
      }

      state = session.copyWith(
        puzzleIndex: session.puzzleIndex + 1,
        correctCount: updatedCorrectCount,
        clearSelectedIndex: true,
        clearXpGainAmount: true,
        result: PuzzleAnswerResult.none,
      );
      return null;
    }

    state = session.copyWith(
      clearSelectedIndex: true,
      result: PuzzleAnswerResult.none,
    );
    return null;
  }

  Future<void> _recordAttempt({
    required Puzzle puzzle,
    required bool isCorrect,
    required int xpEarned,
  }) async {
    await ref.read(progressRepositoryProvider).recordAttempt(
          userId: ref.read(currentUserIdProvider),
          attempt: storedAttemptFrom(
            puzzle: puzzle,
            isCorrect: isCorrect,
            xpEarned: xpEarned,
          ),
        );
  }

  Future<void> _recordLessonResult(LessonResult result) async {
    await ref.read(progressRepositoryProvider).recordLessonResult(
          userId: ref.read(currentUserIdProvider),
          result: storedLessonResultFrom(result),
        );
  }
}

final lessonSessionProvider =
    NotifierProvider<LessonSessionNotifier, LessonSessionState?>(
  LessonSessionNotifier.new,
);

final generateLessonProvider = Provider.family<Lesson, String>(
  (ref, title) => ref.watch(lessonGeneratorProvider).generate(title: title),
);
