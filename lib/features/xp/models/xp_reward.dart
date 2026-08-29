import '../../puzzle/models/puzzle_difficulty.dart';

class XpReward {
  const XpReward({
    required this.amount,
    required this.difficulty,
  });

  final int amount;
  final PuzzleDifficulty difficulty;
}
