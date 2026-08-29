import 'package:flutter/material.dart';

import '../lesson/generators/lesson_generator.dart';
import '../lesson/lesson_screen.dart';
import '../level/widgets/level_progress_bar.dart';
import '../streak/widgets/streak_badge.dart';
import '../streak/widgets/streak_scope.dart';
import '../xp/widgets/xp_badge.dart';
import '../xp/widgets/xp_scope.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final xpController = XpScope.of(context);
    final streakController = StreakScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Good evening 👋',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  ListenableBuilder(
                    listenable: xpController,
                    builder: (context, _) {
                      return XpBadge(total: xpController.total);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ListenableBuilder(
                listenable: streakController,
                builder: (context, _) {
                  if (streakController.streak == 0) {
                    return const SizedBox.shrink();
                  }
                  return StreakBadge(streak: streakController.streak);
                },
              ),
              const SizedBox(height: 12),
              ListenableBuilder(
                listenable: xpController,
                builder: (context, _) {
                  return LevelProgressBar(totalXp: xpController.total);
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Ready for your first lesson?',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    final lesson = LessonGenerator().generate();
                    Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (context) => LessonScreen(lesson: lesson),
                      ),
                    );
                  },
                  child: const Text('Start'),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
