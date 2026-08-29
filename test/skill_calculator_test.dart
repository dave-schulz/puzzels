import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/puzzle/models/puzzle_difficulty.dart';
import 'package:brainy/features/skill/models/skill_category.dart';
import 'package:brainy/features/skill/models/user_skills.dart';
import 'package:brainy/features/skill/skill_calculator.dart';

void main() {
  group('SkillCalculator', () {
    test('increases skill on correct answer', () {
      expect(
        SkillCalculator.adjust(50, isCorrect: true),
        55,
      );
    });

    test('decreases skill on incorrect answer', () {
      expect(
        SkillCalculator.adjust(50, isCorrect: false),
        45,
      );
    });

    test('clamps skill between 0 and 100', () {
      expect(
        SkillCalculator.adjust(98, isCorrect: true),
        100,
      );
      expect(
        SkillCalculator.adjust(2, isCorrect: false),
        0,
      );
    });

    test('maps skill to puzzle difficulty', () {
      expect(
        SkillCalculator.difficultyFor(20),
        PuzzleDifficulty.easy,
      );
      expect(
        SkillCalculator.difficultyFor(50),
        PuzzleDifficulty.medium,
      );
      expect(
        SkillCalculator.difficultyFor(80),
        PuzzleDifficulty.hard,
      );
    });

    test('derives difficulty per category from user skills', () {
      const skills = UserSkills(sequence: 20, logic: 50, pattern: 80);

      expect(
        SkillCalculator.difficultyForCategory(
          skills,
          SkillCategory.sequence,
        ),
        PuzzleDifficulty.easy,
      );
      expect(
        SkillCalculator.difficultyForCategory(
          skills,
          SkillCategory.logic,
        ),
        PuzzleDifficulty.medium,
      );
      expect(
        SkillCalculator.difficultyForCategory(
          skills,
          SkillCategory.pattern,
        ),
        PuzzleDifficulty.hard,
      );
    });
  });
}
