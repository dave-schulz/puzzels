import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'models/puzzle.dart';
import 'widgets/answer_button.dart';
import 'widgets/answer_list.dart';
import 'widgets/puzzle_feedback.dart';
import 'widgets/puzzle_progress.dart';
import 'widgets/puzzle_renderer.dart';

enum _PuzzleResult { none, correct, incorrect }

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({
    super.key,
    required this.puzzles,
  });

  final List<Puzzle> puzzles;

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen>
    with SingleTickerProviderStateMixin {
  static const _totalSteps = 5;

  late int _puzzleIndex;
  int _hearts = 5;
  int? _selectedIndex;
  _PuzzleResult _result = _PuzzleResult.none;
  late final AnimationController _shakeController;

  Puzzle get _puzzle => widget.puzzles[_puzzleIndex];

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
  bool get _isLastPuzzle => _puzzleIndex >= widget.puzzles.length - 1;

  void _selectAnswer(int index) {
    if (_isAnswered) return;

    setState(() => _selectedIndex = index);

    if (index == _puzzle.correctIndex) {
      setState(() => _result = _PuzzleResult.correct);
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

  void _onContinue() {
    if (_result == _PuzzleResult.correct) {
      if (_isLastPuzzle) {
        Navigator.of(context).pop();
        return;
      }
      setState(() {
        _puzzleIndex++;
        _selectedIndex = null;
        _result = _PuzzleResult.none;
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          PuzzleProgress(
            total: _totalSteps,
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
                      return Transform.translate(offset: offset, child: child);
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
              onContinue: _onContinue,
            ),
        ],
      ),
    );
  }
}
