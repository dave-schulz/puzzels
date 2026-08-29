import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/data/local/local_user.dart';
import 'package:brainy/data/models/stored_progress.dart';
import 'package:brainy/data/repositories/local_progress_repository.dart';
import 'package:brainy/providers/database_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppDatabase', () {
    test('creates default local user on first open', () async {
      final database = await createTestAppDatabase();
      addTearDown(database.close);

      final user = await (database.select(database.users)
            ..where((row) => row.id.equals(localUserId)))
          .getSingle();

      expect(user.displayName, defaultDisplayName);
    });

    test('reads default local user from repository', () async {
      final database = await createTestAppDatabase();
      addTearDown(database.close);
      final repository = LocalProgressRepository(database);

      final user = await repository.getUser(localUserId);

      expect(user!.displayName, defaultDisplayName);
    });

    test('seeds default progress row for local user', () async {
      final database = await createTestAppDatabase();
      addTearDown(database.close);
      final repository = LocalProgressRepository(database);

      final progress = await repository.getProgress(localUserId);

      expect(progress, isNotNull);
      expect(progress!.totalXp, 0);
      expect(progress.streak, 0);
      expect(progress.sequenceSkill, 50);
      expect(progress.logicSkill, 50);
      expect(progress.patternSkill, 50);
    });

    test('persists and reads user progress', () async {
      final database = await createTestAppDatabase();
      addTearDown(database.close);
      final repository = LocalProgressRepository(database);
      final lastPlayDate = DateTime(2026, 8, 29);

      await repository.saveProgress(
        userId: localUserId,
        totalXp: 120,
        streak: 3,
        lastPlayDate: lastPlayDate,
        sequenceSkill: 55,
        logicSkill: 60,
        patternSkill: 45,
      );

      final progress = await repository.getProgress(localUserId);

      expect(progress!.totalXp, 120);
      expect(progress.streak, 3);
      expect(progress.lastPlayDate, lastPlayDate);
      expect(progress.sequenceSkill, 55);
      expect(progress.logicSkill, 60);
      expect(progress.patternSkill, 45);
    });

    test('records puzzle attempts', () async {
      final database = await createTestAppDatabase();
      addTearDown(database.close);
      final repository = LocalProgressRepository(database);

      await repository.recordAttempt(
        userId: localUserId,
        attempt: StoredAttempt(
          puzzleId: 'seq-1',
          puzzleType: 'sequence',
          difficulty: 'easy',
          isCorrect: true,
          xpEarned: 10,
          attemptedAt: DateTime(2026, 8, 29, 12),
        ),
      );

      final attempts = await database.select(database.attempts).get();
      expect(attempts, hasLength(1));
      expect(attempts.first.puzzleId, 'seq-1');
      expect(attempts.first.xpEarned, 10);
    });

    test('records lesson results', () async {
      final database = await createTestAppDatabase();
      addTearDown(database.close);
      final repository = LocalProgressRepository(database);

      await repository.recordLessonResult(
        userId: localUserId,
        result: StoredLessonResult(
          correctCount: 4,
          totalCount: 5,
          xpEarned: 80,
          completedAt: DateTime(2026, 8, 29, 13),
        ),
      );

      final results = await database.select(database.lessonResults).get();
      expect(results, hasLength(1));
      expect(results.first.correctCount, 4);
      expect(results.first.xpEarned, 80);
    });
  });
}
