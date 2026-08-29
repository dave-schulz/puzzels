import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/data/local/local_user.dart';
import 'package:brainy/data/repositories/local_progress_repository.dart';
import 'package:brainy/providers/database_provider.dart';
import 'package:brainy/providers/lesson_provider.dart';
import 'package:brainy/providers/progress_persistence.dart';
import 'package:brainy/providers/puzzle_provider.dart';
import 'package:brainy/providers/skills_provider.dart';
import 'package:brainy/providers/streak_provider.dart';
import 'package:brainy/providers/user_provider.dart';
import 'package:brainy/providers/xp_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Progress persistence', () {
    test('hydrates user profile, XP and streak from local database', () async {
      final database = await createTestAppDatabase();
      final repository = LocalProgressRepository(database);
      addTearDown(database.close);

      await repository.saveProgress(
        userId: localUserId,
        totalXp: 120,
        streak: 2,
        lastPlayDate: DateTime(2026, 8, 29),
        sequenceSkill: 65,
        logicSkill: 40,
        patternSkill: 75,
      );

      final container = ProviderContainer(
        overrides: [
          progressRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      await hydratePersistedProgress(container);

      expect(container.read(userProfileProvider).displayName, defaultDisplayName);
      expect(container.read(xpProvider), 120);
      expect(container.read(streakProvider).streak, 2);
      expect(container.read(skillsProvider).sequence, 65);
      expect(container.read(skillsProvider).logic, 40);
      expect(container.read(skillsProvider).pattern, 75);
    });

    test('adding XP persists to local database', () async {
      final database = await createTestAppDatabase();
      final repository = LocalProgressRepository(database);
      addTearDown(database.close);

      final container = ProviderContainer(
        overrides: [
          progressRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      container.read(xpProvider.notifier).add(50);
      await Future<void>.delayed(Duration.zero);

      final progress = await repository.getProgress(localUserId);

      expect(progress!.totalXp, 50);
    });

    test('lesson attempts are stored locally', () async {
      final database = await createTestAppDatabase();
      final repository = LocalProgressRepository(database);
      addTearDown(database.close);

      final container = ProviderContainer(
        overrides: [
          progressRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);

      final lesson = container.read(lessonGeneratorProvider).generate();
      final notifier = container.read(lessonSessionProvider.notifier);
      notifier.start(lesson);

      final session = container.read(lessonSessionProvider)!;
      notifier.selectAnswer(session.currentPuzzle.correctIndex);
      await Future<void>.delayed(Duration.zero);

      final attempts = await database.select(database.attempts).get();
      expect(attempts, hasLength(1));
      expect(attempts.first.isCorrect, isTrue);
    });
  });
}
