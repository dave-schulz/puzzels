import 'package:drift/drift.dart';

import 'connection.dart';
import 'local_user.dart';
import 'tables/brainy_tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, UserProgress, Attempts, LessonResults])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? openConnection());

  AppDatabase.forTesting([QueryExecutor? executor])
      : super(executor ?? openTestConnection());

  @override
  int get schemaVersion => 1;

  Future<void> ensureDefaultUser({
    String userId = localUserId,
    String displayName = defaultDisplayName,
  }) async {
    final existingUser = await (select(users)
          ..where((user) => user.id.equals(userId)))
        .getSingleOrNull();

    if (existingUser != null) return;

    final now = DateTime.now();
    await transaction(() async {
      await into(users).insert(
        UsersCompanion.insert(
          id: userId,
          displayName: displayName,
          createdAt: now,
        ),
      );
      await into(userProgress).insert(
        UserProgressCompanion.insert(
          userId: userId,
          updatedAt: now,
        ),
      );
    });
  }
}
