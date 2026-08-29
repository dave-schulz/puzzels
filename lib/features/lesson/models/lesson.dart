import '../../puzzle/models/puzzle.dart';

class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.puzzles,
    this.isDailyChallenge = false,
  });

  final String id;
  final String title;
  final List<Puzzle> puzzles;
  final bool isDailyChallenge;

  int get puzzleCount => puzzles.length;
}
