import 'package:flutter/material.dart';

import '../lesson/generators/lesson_generator.dart';
import '../lesson/lesson_screen.dart';
import '../streak/widgets/streak_scope.dart';
import '../xp/widgets/xp_scope.dart';
import 'home_greeting.dart';
import 'widgets/continue_training_card.dart';
import 'widgets/daily_challenge_card.dart';
import 'widgets/home_stats_row.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _startLesson(BuildContext context) {
    final lesson = LessonGenerator().generate();
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) => LessonScreen(lesson: lesson),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final xpController = XpScope.of(context);
    final streakController = StreakScope.of(context);

    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ListenableBuilder(
            listenable: Listenable.merge([xpController, streakController]),
            builder: (context, _) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      '${homeGreeting()} 👋',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    HomeStatsRow(
                      streak: streakController.streak,
                      totalXp: xpController.total,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Continue training',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ContinueTrainingCard(
                      totalXp: xpController.total,
                      onContinue: () => _startLesson(context),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Daily Challenge',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DailyChallengeCard(
                      onTap: () => _startLesson(context),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
