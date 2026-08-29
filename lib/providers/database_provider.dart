import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/app_database.dart';
import '../data/repositories/local_progress_repository.dart';
import '../data/repositories/progress_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('AppDatabase must be provided via ProviderScope');
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  return LocalProgressRepository(ref.watch(appDatabaseProvider));
});

Future<AppDatabase> createAppDatabase() async {
  final database = AppDatabase();
  await database.ensureDefaultUser();
  return database;
}

Future<AppDatabase> createTestAppDatabase() async {
  final database = AppDatabase.forTesting();
  await database.ensureDefaultUser();
  return database;
}
