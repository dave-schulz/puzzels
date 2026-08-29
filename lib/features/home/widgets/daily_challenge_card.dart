import 'package:flutter/material.dart';

import '../../daily_challenge/daily_challenge_constants.dart';

class DailyChallengeCard extends StatelessWidget {
  const DailyChallengeCard({
    super.key,
    required this.completedToday,
    required this.onTap,
  });

  final bool completedToday;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: completedToday
          ? theme.colorScheme.surfaceContainerHighest
          : theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: completedToday
                  ? theme.colorScheme.outlineVariant
                  : theme.colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '⭐ ${DailyChallengeConstants.puzzleCount} puzzles',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        completedToday
                            ? 'Completed today'
                            : 'Complete today\'s set',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (!completedToday)
                        Text(
                          '+${DailyChallengeConstants.bonusXp} XP bonus',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  completedToday ? Icons.check_circle : Icons.chevron_right,
                  color: completedToday
                      ? theme.colorScheme.primary
                      : theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
