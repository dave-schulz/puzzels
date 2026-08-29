import '../../puzzle/models/puzzle_type.dart';

enum SkillCategory {
  sequence,
  logic,
  pattern,
}

SkillCategory skillCategoryFor(PuzzleType type) {
  return switch (type) {
    PuzzleType.sequence => SkillCategory.sequence,
    PuzzleType.multipleChoice => SkillCategory.logic,
    PuzzleType.pattern => SkillCategory.pattern,
  };
}
