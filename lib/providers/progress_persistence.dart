import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/skill/models/user_skills.dart';
import 'database_provider.dart';
import 'skills_provider.dart';
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
  container.read(skillsProvider.notifier).restore(
        UserSkills(
          sequence: progress.sequenceSkill,
          logic: progress.logicSkill,
          pattern: progress.patternSkill,
        ),
      );
}

Future<void> persistUserProgress(
  Ref ref, {
  required int totalXp,
  required int streak,
  DateTime? lastPlayDate,
  required UserSkills skills,
}) async {
  await ref.read(progressRepositoryProvider).saveProgress(
        userId: ref.read(currentUserIdProvider),
        totalXp: totalXp,
        streak: streak,
        lastPlayDate: lastPlayDate,
        sequenceSkill: skills.sequence,
        logicSkill: skills.logic,
        patternSkill: skills.pattern,
      );
}

Future<void> persistXpProgress(Ref ref, int totalXp) async {
  final streak = ref.read(streakProvider);
  await persistUserProgress(
    ref,
    totalXp: totalXp,
    streak: streak.streak,
    lastPlayDate: streak.lastPlayDate,
    skills: ref.read(skillsProvider),
  );
}

Future<void> persistStreakProgress(Ref ref, StreakData streak) async {
  await persistUserProgress(
    ref,
    totalXp: ref.read(xpProvider),
    streak: streak.streak,
    lastPlayDate: streak.lastPlayDate,
    skills: ref.read(skillsProvider),
  );
}

Future<void> persistSkillsProgress(Ref ref, UserSkills skills) async {
  final streak = ref.read(streakProvider);
  await persistUserProgress(
    ref,
    totalXp: ref.read(xpProvider),
    streak: streak.streak,
    lastPlayDate: streak.lastPlayDate,
    skills: skills,
  );
}
