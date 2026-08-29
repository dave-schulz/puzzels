import '../puzzle/models/puzzle_difficulty.dart';
import 'models/xp_reward.dart';

abstract final class XpCalculator {
  static int amountFor(PuzzleDifficulty difficulty) {
    return switch (difficulty) {
      PuzzleDifficulty.easy => 10,
      PuzzleDifficulty.medium => 20,
      PuzzleDifficulty.hard => 30,
    };
  }

  static XpReward rewardFor(PuzzleDifficulty difficulty) {
    return XpReward(
      amount: amountFor(difficulty),
      difficulty: difficulty,
    );
  }
}
