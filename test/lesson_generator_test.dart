import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/lesson/generators/lesson_generator.dart';
import 'package:brainy/features/puzzle/models/puzzle_difficulty.dart';
import 'package:brainy/features/puzzle/models/puzzle_type.dart';
import 'package:brainy/features/skill/models/user_skills.dart';

void main() {
  group('LessonGenerator', () {
    test('generates lesson with five puzzles', () {
      final lesson = LessonGenerator().generate();

      expect(lesson.puzzles, hasLength(5));
    });

    test('includes sequence, logic, and pattern puzzles', () {
      final lesson = LessonGenerator().generate();
      final types = lesson.puzzles.map((puzzle) => puzzle.type).toSet();

      expect(types, contains(PuzzleType.sequence));
      expect(types, contains(PuzzleType.multipleChoice));
      expect(types, contains(PuzzleType.pattern));
    });

    test('selects difficulties from user skills', () {
      const skills = UserSkills(sequence: 20, logic: 50, pattern: 80);
      final plan = LessonGenerator.planForSkills(skills);

      expect(plan[0].difficulty, PuzzleDifficulty.easy);
      expect(plan[1].difficulty, PuzzleDifficulty.hard);
      expect(plan[2].difficulty, PuzzleDifficulty.medium);
      expect(plan[3].difficulty, PuzzleDifficulty.easy);
      expect(plan[4].difficulty, PuzzleDifficulty.easy);

      final lesson = LessonGenerator().generate(skills: skills);
      expect(lesson.puzzles[0].difficulty, PuzzleDifficulty.easy);
      expect(lesson.puzzles[1].difficulty, PuzzleDifficulty.hard);
      expect(lesson.puzzles[2].difficulty, PuzzleDifficulty.medium);
    });
  });
}
