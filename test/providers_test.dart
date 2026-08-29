import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/providers/home_provider.dart';
import 'package:brainy/providers/lesson_provider.dart';
import 'package:brainy/providers/progress_provider.dart';
import 'package:brainy/providers/puzzle_provider.dart';
import 'package:brainy/providers/streak_provider.dart';
import 'package:brainy/providers/xp_provider.dart';

void main() {
  group('Riverpod providers', () {
    test('xpProvider tracks XP and level', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      expect(container.read(totalXpProvider), 0);
      expect(container.read(levelProvider), 1);

      container.read(xpProvider.notifier).add(100);
      expect(container.read(totalXpProvider), 100);
      expect(container.read(levelProvider), 2);
    });

    test('streakProvider records lesson completion', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(streakProvider.notifier)
          .recordLessonCompleted(DateTime(2026, 1, 1));

      expect(container.read(streakCountProvider), 1);
    });

    test('lessonGeneratorProvider creates five-puzzle lessons', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final lesson = container.read(lessonGeneratorProvider).generate();
      expect(lesson.puzzles, hasLength(5));
    });

    test('lessonSessionProvider manages lesson flow', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final lesson = container.read(lessonGeneratorProvider).generate();
      final notifier = container.read(lessonSessionProvider.notifier);

      notifier.start(lesson);
      final session = container.read(lessonSessionProvider)!;
      final correctIndex = session.currentPuzzle.correctIndex;

      notifier.selectAnswer(correctIndex);
      expect(container.read(lessonSessionProvider)!.result,
          PuzzleAnswerResult.correct);

      final finished = notifier.continueAfterFeedback();
      expect(finished, isNull);
      expect(container.read(lessonSessionProvider)!.puzzleIndex, 1);
    });

    test('homeStateProvider combines user, XP, and streak', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(xpProvider.notifier).add(50);
      container
          .read(streakProvider.notifier)
          .recordLessonCompleted(DateTime(2026, 1, 1));

      final homeState = container.read(homeStateProvider);
      expect(homeState.displayName, 'Davey');
      expect(homeState.totalXp, 50);
      expect(homeState.streak, 1);
      expect(homeState.levelProgress.level, 1);
    });

    test('levelProgressProvider derives from XP', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(xpProvider.notifier).add(100);
      expect(container.read(levelProgressProvider).level, 2);
    });
  });
}
