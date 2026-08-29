import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database_provider.dart';
import 'streak_provider.dart';
import 'user_provider.dart';
import 'xp_provider.dart';

Future<void> hydratePersistedProgress(ProviderContainer container) async {
  final userId = container.read(currentUserIdProvider);
  final repository = container.read(progressRepositoryProvider);

  final user = await repository.getUser(userId);
  if (user != null) {
    container.read(userProfileProvider.notifier).restore(user.displayName);
  }

  final progress = await repository.getProgress(userId);
  if (progress == null) return;

  container.read(xpProvider.notifier).restore(progress.totalXp);
  container.read(streakProvider.notifier).restore(
        streak: progress.streak,
        lastPlayDate: progress.lastPlayDate,
      );
}

Future<void> persistUserProgress(
  Ref ref, {
  required int totalXp,
  required int streak,
  DateTime? lastPlayDate,
}) async {
  await ref.read(progressRepositoryProvider).saveProgress(
        userId: ref.read(currentUserIdProvider),
        totalXp: totalXp,
        streak: streak,
        lastPlayDate: lastPlayDate,
      );
}

Future<void> persistXpProgress(Ref ref, int totalXp) async {
  final streak = ref.read(streakProvider);
  await persistUserProgress(
    ref,
    totalXp: totalXp,
    streak: streak.streak,
    lastPlayDate: streak.lastPlayDate,
  );
}

Future<void> persistStreakProgress(Ref ref, StreakData streak) async {
  await persistUserProgress(
    ref,
    totalXp: ref.read(xpProvider),
    streak: streak.streak,
    lastPlayDate: streak.lastPlayDate,
  );
}
