import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/app_database.dart';
import '../data/repositories/local_progress_repository.dart';
import '../data/repositories/progress_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('AppDatabase must be provided via ProviderScope');
});

/// Override in main (or tests) to wire local or remote storage.
final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  throw UnimplementedError(
    'ProgressRepository must be provided via ProviderScope overrides',
  );
});

Future<LocalProgressRepository> createLocalProgressRepository() async {
  final database = AppDatabase();
  await database.ensureDefaultUser();
  return LocalProgressRepository(database);
}

Future<AppDatabase> createTestAppDatabase() async {
  final database = AppDatabase.forTesting();
  await database.ensureDefaultUser();
  return database;
}
