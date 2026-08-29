import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/local_user.dart';
import 'database_provider.dart';
import 'streak_provider.dart';
import 'xp_provider.dart';

Future<void> hydratePersistedProgress(ProviderContainer container) async {
  final progress =
      await container.read(progressRepositoryProvider).getProgress(localUserId);
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
        userId: localUserId,
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
