import 'package:flutter/material.dart';

import '../level_calculator.dart';

class LevelProgressBar extends StatelessWidget {
  const LevelProgressBar({
    super.key,
    required this.totalXp,
  });

  final int totalXp;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = LevelCalculator.progressFor(totalXp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Level ${progress.level}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              progress.isMaxLevel
                  ? '${progress.totalXp} XP'
                  : '${progress.xpIntoLevel} / ${progress.xpNeededForNext} XP',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress.progress,
            minHeight: 12,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
