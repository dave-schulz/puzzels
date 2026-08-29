import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../level/level_up_screen.dart';
import '../puzzle/models/puzzle.dart';
import '../puzzle/widgets/answer_button.dart';
import '../puzzle/widgets/answer_list.dart';
import '../puzzle/widgets/puzzle_feedback.dart';
import '../puzzle/widgets/puzzle_progress.dart';
import '../puzzle/widgets/puzzle_renderer.dart';
import '../streak/widgets/streak_scope.dart';
import '../xp/widgets/xp_gain_animation.dart';
import '../xp/widgets/xp_scope.dart';
import '../xp/xp_calculator.dart';
import 'lesson_result_screen.dart';
import 'models/lesson.dart';
import 'models/lesson_result.dart';

enum _PuzzleResult { none, correct, incorrect }

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.lesson,
  });

  final Lesson lesson;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with SingleTickerProviderStateMixin {
  late int _puzzleIndex;
  int _correctCount = 0;
  int _sessionXpEarned = 0;
  int _hearts = 5;
  int? _selectedIndex;
  int? _xpGainAmount;
  int _xpAnimationKey = 0;
  _PuzzleResult _result = _PuzzleResult.none;
  late final AnimationController _shakeController;

  Puzzle get _puzzle => widget.lesson.puzzles[_puzzleIndex];

  @override
  void initState() {
    super.initState();
    _puzzleIndex = 0;
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

  bool get _isAnswered => _result != _PuzzleResult.none;
  bool get _isLastPuzzle =>
      _puzzleIndex >= widget.lesson.puzzles.length - 1;

  void _selectAnswer(int index) {
    if (_isAnswered) return;

    setState(() => _selectedIndex = index);

    if (index == _puzzle.correctIndex) {
      final reward = XpCalculator.rewardFor(_puzzle.difficulty);
      final levelUp = XpScope.of(context).add(reward.amount);
      setState(() {
        _result = _PuzzleResult.correct;
        _sessionXpEarned += reward.amount;
        _xpGainAmount = reward.amount;
        _xpAnimationKey++;
      });
      if (levelUp != null && mounted) {
        _showLevelUp(levelUp.toLevel);
      }
    } else {
      _shakeController.forward(from: 0);
      setState(() {
        _result = _PuzzleResult.incorrect;
        _hearts = (_hearts - 1).clamp(0, 5);
      });
    }
  }

  AnswerState _stateForIndex(int index) {
    if (!_isAnswered) {
      return _selectedIndex == index ? AnswerState.selected : AnswerState.idle;
    }
    if (index == _puzzle.correctIndex) return AnswerState.correct;
    if (index == _selectedIndex) return AnswerState.incorrect;
    return AnswerState.idle;
  }

  void _finishLesson() {
    StreakScope.of(context).recordLessonCompleted();

    final result = LessonResult(
      correctCount: _correctCount,
      totalCount: widget.lesson.puzzleCount,
      xpEarned: _sessionXpEarned,
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => LessonResultScreen(result: result),
      ),
    );
  }

  Future<void> _showLevelUp(int level) {
    return Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => LevelUpScreen(level: level),
      ),
    );
  }

  void _onContinue() {
    if (_result == _PuzzleResult.correct) {
      _correctCount++;

      if (_isLastPuzzle) {
        _finishLesson();
        return;
      }

      setState(() {
        _puzzleIndex++;
        _selectedIndex = null;
        _result = _PuzzleResult.none;
        _xpGainAmount = null;
      });
      return;
    }

    setState(() {
      _selectedIndex = null;
      _result = _PuzzleResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final puzzleNumber = _puzzleIndex + 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('$puzzleNumber / ${widget.lesson.puzzleCount}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                Icon(Icons.favorite, color: theme.colorScheme.error),
                const SizedBox(width: 4),
                Text(
                  '$_hearts',
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
                total: widget.lesson.puzzleCount,
                completed: _puzzleIndex,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedBuilder(
                        animation: _shakeController,
                        builder: (context, child) {
                          final shake = _shakeController.value;
                          final offset = _result == _PuzzleResult.incorrect
                              ? Offset(math.sin(shake * 4 * math.pi) * 8, 0)
                              : Offset.zero;
                          return Transform.translate(
                            offset: offset,
                            child: child,
                          );
                        },
                        child: PuzzleRenderer(puzzle: _puzzle),
                      ),
                      const Spacer(),
                      AnswerList(
                        options: _puzzle.options,
                        enabled: !_isAnswered,
                        stateForIndex: _stateForIndex,
                        onSelected: _selectAnswer,
                      ),
                    ],
                  ),
                ),
              ),
              if (_isAnswered)
                PuzzleFeedback(
                  type: _result == _PuzzleResult.correct
                      ? FeedbackType.correct
                      : FeedbackType.incorrect,
                  correctAnswer: _puzzle.correctAnswer,
                  continueLabel:
                      _result == _PuzzleResult.correct && _isLastPuzzle
                          ? 'Finish'
                          : 'Continue',
                  onContinue: _onContinue,
                ),
            ],
          ),
          if (_xpGainAmount != null)
            Positioned(
              bottom: 180,
              child: XpGainAnimation(
                key: ValueKey(_xpAnimationKey),
                amount: _xpGainAmount!,
              ),
            ),
        ],
      ),
    );
  }
}
