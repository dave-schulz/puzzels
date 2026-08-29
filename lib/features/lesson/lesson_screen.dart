import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/lesson_provider.dart';
import '../level/level_up_screen.dart';
import '../puzzle/widgets/answer_list.dart';
import '../puzzle/widgets/puzzle_feedback.dart';
import '../puzzle/widgets/puzzle_progress.dart';
import '../puzzle/widgets/puzzle_renderer.dart';
import '../xp/widgets/xp_gain_animation.dart';
import 'lesson_result_screen.dart';

class LessonScreen extends ConsumerStatefulWidget {
  const LessonScreen({super.key});

  @override
  ConsumerState<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends ConsumerState<LessonScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _showLevelUp(int level) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => LevelUpScreen(level: level),
      ),
    );
  }

  void _selectAnswer(int index) {
    final levelUp =
        ref.read(lessonSessionProvider.notifier).selectAnswer(index);

    final session = ref.read(lessonSessionProvider);
    if (session?.result == PuzzleAnswerResult.incorrect) {
      _shakeController.forward(from: 0);
    }

    if (levelUp != null && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showLevelUp(levelUp.toLevel);
        }
      });
    }
  }

  void _onContinue() {
    final result =
        ref.read(lessonSessionProvider.notifier).continueAfterFeedback();

    if (result != null && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => LessonResultScreen(result: result),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(lessonSessionProvider);
    if (session == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    final puzzle = session.currentPuzzle;
    final puzzleNumber = session.puzzleIndex + 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            ref.read(lessonSessionProvider.notifier).clear();
            Navigator.of(context).pop();
          },
        ),
        title: Text('$puzzleNumber / ${session.lesson.puzzleCount}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Icon(Icons.favorite, color: theme.colorScheme.error),
                const SizedBox(width: 4),
                Text(
                  '${session.hearts}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              PuzzleProgress(
                total: session.lesson.puzzleCount,
                completed: session.puzzleIndex,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: AnimatedBuilder(
                            animation: _shakeController,
                            builder: (context, child) {
                              final shake = _shakeController.value;
                              final offset =
                                  session.result == PuzzleAnswerResult.incorrect
                                      ? Offset(
                                          math.sin(shake * 4 * math.pi) * 8,
                                          0,
                                        )
                                      : Offset.zero;
                              return Transform.translate(
                                offset: offset,
                                child: child,
                              );
                            },
                            child: PuzzleRenderer(puzzle: puzzle),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AnswerList(
                        options: puzzle.options,
                        enabled: !session.isAnswered,
                        stateForIndex: session.answerStateForIndex,
                        onSelected: _selectAnswer,
                      ),
                    ],
                  ),
                ),
              ),
              if (session.isAnswered)
                PuzzleFeedback(
                  type: session.result == PuzzleAnswerResult.correct
                      ? FeedbackType.correct
                      : FeedbackType.incorrect,
                  correctAnswer: puzzle.correctAnswer,
                  continueLabel:
                      session.result == PuzzleAnswerResult.correct &&
                              session.isLastPuzzle
                          ? 'Finish'
                          : 'Continue',
                  onContinue: _onContinue,
                ),
            ],
          ),
          if (session.xpGainAmount != null)
            Positioned(
              bottom: 180,
              child: XpGainAnimation(
                key: ValueKey(session.xpAnimationKey),
                amount: session.xpGainAmount!,
              ),
            ),
        ],
      ),
    );
  }
}
