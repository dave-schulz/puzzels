import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../lesson/lesson_screen.dart';
import '../../providers/home_provider.dart';
import '../../providers/lesson_provider.dart';
import '../../providers/puzzle_provider.dart';
import '../../providers/skills_provider.dart';
import 'home_greeting.dart';
import 'widgets/continue_training_card.dart';
import 'widgets/daily_challenge_card.dart';
import 'widgets/home_stats_row.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
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

  void _startLesson() {
    final skills = ref.read(skillsProvider);
    final lesson = ref.read(lessonGeneratorProvider).generate(skills: skills);
    ref.read(lessonSessionProvider.notifier).start(lesson);
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (context) => const LessonScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeState = ref.watch(homeStateProvider);

    return Scaffold(
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  '${homeGreeting()}, ${homeState.displayName} 👋',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                HomeStatsRow(
                  streak: homeState.streak,
                  totalXp: homeState.totalXp,
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
                  totalXp: homeState.totalXp,
                  onContinue: _startLesson,
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
                  onTap: _startLesson,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
