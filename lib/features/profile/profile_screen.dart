import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/progress_provider.dart';
import '../../providers/streak_provider.dart';
import '../../providers/xp_provider.dart';
import '../level/widgets/level_progress_bar.dart';
import '../streak/widgets/streak_badge.dart';
import '../xp/widgets/xp_badge.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final totalXp = ref.watch(totalXpProvider);
    final streak = ref.watch(streakCountProvider);
    final levelProgress = ref.watch(levelProgressProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 36,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your profile',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            if (streak > 0) ...[
              StreakBadge(streak: streak),
              const SizedBox(height: 12),
            ],
            XpBadge(total: totalXp),
            const SizedBox(height: 16),
            LevelProgressBar(totalXp: totalXp),
            const SizedBox(height: 8),
            Text(
              levelProgress.isMaxLevel
                  ? 'Max level reached'
                  : 'Level ${levelProgress.level}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Stats and settings will appear here.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
