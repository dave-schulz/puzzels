import '../../puzzle/models/puzzle.dart';

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.puzzles,
  });

  final String id;
  final String title;
  final List<Puzzle> puzzles;

  int get puzzleCount => puzzles.length;
}
