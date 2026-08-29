import '../../puzzle/models/puzzle.dart';
import '../../puzzle/widgets/answer_button.dart';
import 'lesson.dart';

enum PuzzleAnswerResult { none, correct, incorrect }

class LessonSessionState {
  const LessonSessionState({
    required this.lesson,
    this.puzzleIndex = 0,
    this.correctCount = 0,
    this.sessionXpEarned = 0,
    this.hearts = 5,
    this.selectedIndex,
    this.xpGainAmount,
    this.xpAnimationKey = 0,
    this.result = PuzzleAnswerResult.none,
  });

  final Lesson lesson;
  final int puzzleIndex;
  final int correctCount;
  final int sessionXpEarned;
  final int hearts;
  final int? selectedIndex;
  final int? xpGainAmount;
  final int xpAnimationKey;
  final PuzzleAnswerResult result;

  Puzzle get currentPuzzle => lesson.puzzles[puzzleIndex];

  bool get isAnswered => result != PuzzleAnswerResult.none;

  bool get isLastPuzzle => puzzleIndex >= lesson.puzzleCount - 1;

  AnswerState answerStateForIndex(int index) {
    if (!isAnswered) {
      return selectedIndex == index ? AnswerState.selected : AnswerState.idle;
    }
    if (index == currentPuzzle.correctIndex) return AnswerState.correct;
    if (index == selectedIndex) return AnswerState.incorrect;
    return AnswerState.idle;
  }

  LessonSessionState copyWith({
    Lesson? lesson,
    int? puzzleIndex,
    int? correctCount,
    int? sessionXpEarned,
    int? hearts,
    int? selectedIndex,
    bool clearSelectedIndex = false,
    int? xpGainAmount,
    bool clearXpGainAmount = false,
    int? xpAnimationKey,
    PuzzleAnswerResult? result,
  }) {
    return LessonSessionState(
      lesson: lesson ?? this.lesson,
      puzzleIndex: puzzleIndex ?? this.puzzleIndex,
      correctCount: correctCount ?? this.correctCount,
      sessionXpEarned: sessionXpEarned ?? this.sessionXpEarned,
      hearts: hearts ?? this.hearts,
      selectedIndex:
          clearSelectedIndex ? null : (selectedIndex ?? this.selectedIndex),
      xpGainAmount:
          clearXpGainAmount ? null : (xpGainAmount ?? this.xpGainAmount),
      xpAnimationKey: xpAnimationKey ?? this.xpAnimationKey,
      result: result ?? this.result,
    );
  }
}
