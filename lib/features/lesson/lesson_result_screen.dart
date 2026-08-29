import 'package:flutter/material.dart';

import '../../../theme/brainy_theme.dart';
import 'models/lesson_result.dart';

class LessonResultScreen extends StatelessWidget {
  const LessonResultScreen({
    super.key,
    required this.result,
  });

  final LessonResult result;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                '🎉 Lesson complete!',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(result.totalCount, (index) {
                  final filled = index < result.starCount;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      filled ? Icons.star : Icons.star_border,
                      size: 36,
                      color: filled
                          ? context.brainyTheme.progressActive
                          : theme.colorScheme.outline,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),
              Text(
                '+${result.xpEarned} XP',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${result.correctCount} / ${result.totalCount} correct',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Continue'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
