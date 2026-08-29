import '../puzzle/models/puzzle_difficulty.dart';
import 'models/skill_category.dart';
import 'models/user_skills.dart';

class SkillCalculator {
  static const minSkill = 0;
  static const maxSkill = 100;
  static const correctDelta = 5;
  static const incorrectDelta = -5;

  static int adjust(int current, {required bool isCorrect}) {
    final delta = isCorrect ? correctDelta : incorrectDelta;
    return (current + delta).clamp(minSkill, maxSkill);
  }

  static PuzzleDifficulty difficultyFor(int skill) {
    if (skill < 34) return PuzzleDifficulty.easy;
    if (skill < 67) return PuzzleDifficulty.medium;
    return PuzzleDifficulty.hard;
  }

  static PuzzleDifficulty difficultyForCategory(
    UserSkills skills,
    SkillCategory category,
  ) {
    return difficultyFor(skills.forCategory(category));
  }
}
