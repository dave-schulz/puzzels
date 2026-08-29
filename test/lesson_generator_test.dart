import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/lesson/generators/lesson_generator.dart';
import 'package:brainy/features/puzzle/generators/sequence_generator.dart';

void main() {
  group('LessonGenerator', () {
    test('generates lesson with five puzzles', () {
      final lesson = LessonGenerator().generate();

      expect(lesson.puzzles, hasLength(5));
      expect(lesson.puzzles.length, SequenceGenerator.defaultSessionDifficulties.length);
    });
  });
}
