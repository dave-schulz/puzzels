import 'puzzle_difficulty.dart';
import 'puzzle_type.dart';

class Puzzle {
  const Puzzle({
    required this.id,
    required this.type,
    required this.difficulty,
    required this.prompt,
    required this.options,
    required this.correctIndex,
    this.sequence,
    this.statements,
  });

  final String id;
  final PuzzleType type;
  final PuzzleDifficulty difficulty;
  final String prompt;
  final List<String> options;
  final int correctIndex;
  final List<String>? sequence;
  final List<String>? statements;

  String get correctAnswer => options[correctIndex];
}
