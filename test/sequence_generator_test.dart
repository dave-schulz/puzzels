import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/puzzle/generators/sequence_generator.dart';
import 'package:brainy/features/puzzle/generators/sequence_pattern.dart';
import 'package:brainy/features/puzzle/models/puzzle_type.dart';

void main() {
  group('SequencePattern', () {
    test('add patterns increase by step', () {
      expect(SequencePattern.add1.next(7), 8);
      expect(SequencePattern.add2.next(7), 9);
      expect(SequencePattern.add3.next(7), 10);
    });

    test('multiply patterns scale value', () {
      expect(SequencePattern.multiply2.next(3), 6);
      expect(SequencePattern.multiply3.next(3), 9);
    });
  });

  group('SequenceGenerator', () {
    test('generates valid +2 sequence puzzle', () {
      final generator = SequenceGenerator(random: Random(1));

      final puzzle = generator.generate();

      expect(puzzle.type, PuzzleType.sequence);
      expect(puzzle.sequence?.last, '?');
      expect(puzzle.options, hasLength(4));
      expect(
        puzzle.options[puzzle.correctIndex],
        puzzle.correctAnswer,
      );
    });

    test('example +2 sequence produces expected answer', () {
      final generator = SequenceGenerator(random: Random(42));
      final puzzle = generator.generate();

      if (puzzle.sequence!.contains('7') &&
          puzzle.sequence!.contains('9') &&
          puzzle.sequence!.contains('11') &&
          puzzle.sequence!.contains('13')) {
        expect(puzzle.correctAnswer, '15');
      }
    });

    test('generateSession returns requested count', () {
      final generator = SequenceGenerator(random: Random(0));
      final session = generator.generateSession(count: 5);

      expect(session, hasLength(5));
      expect(session.every((puzzle) => puzzle.type == PuzzleType.sequence), true);
    });

    test('options are unique and include correct answer', () {
      final generator = SequenceGenerator(random: Random(99));

      for (var i = 0; i < 20; i++) {
        final puzzle = generator.generate();
        expect(puzzle.options.toSet(), hasLength(4));
        expect(puzzle.options, contains(puzzle.correctAnswer));
      }
    });
  });
}
