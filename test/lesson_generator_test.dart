import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/lesson/generators/lesson_generator.dart';
import 'package:brainy/features/puzzle/models/puzzle_type.dart';

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
  });
}
