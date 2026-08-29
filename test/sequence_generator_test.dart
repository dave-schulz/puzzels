import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/puzzle/generators/sequence_generator.dart';
import 'package:brainy/features/puzzle/generators/sequence_pattern.dart';
import 'package:brainy/features/puzzle/models/puzzle_difficulty.dart';
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
    test('generates valid sequence puzzle', () {
      final generator = SequenceGenerator(random: Random(1));
      final puzzle = generator.generate(difficulty: PuzzleDifficulty.easy);

      expect(puzzle.type, PuzzleType.sequence);
      expect(puzzle.difficulty, PuzzleDifficulty.easy);
      expect(puzzle.sequence?.last, '?');
      expect(puzzle.options, hasLength(4));
      expect(puzzle.options[puzzle.correctIndex], puzzle.correctAnswer);
    });

    test('generateSession follows default difficulty curve', () {
      final generator = SequenceGenerator(random: Random(0));
      final session = generator.generateSession();

      expect(session, hasLength(5));
      expect(session[0].difficulty, PuzzleDifficulty.easy);
      expect(session[1].difficulty, PuzzleDifficulty.easy);
      expect(session[2].difficulty, PuzzleDifficulty.medium);
      expect(session[3].difficulty, PuzzleDifficulty.medium);
      expect(session[4].difficulty, PuzzleDifficulty.hard);
    });

    test('easy puzzles only use easy patterns', () {
      final generator = SequenceGenerator(random: Random(0));
      const easyPatterns = {SequencePattern.add1, SequencePattern.add2};

      for (var i = 0; i < 30; i++) {
        final puzzle = generator.generate(difficulty: PuzzleDifficulty.easy);
        final values = puzzle.sequence!
            .where((value) => value != '?')
            .map(int.parse)
            .toList();
        expect(_detectPattern(values), isIn(easyPatterns));
      }
    });

    test('hard puzzles only use hard patterns', () {
      final generator = SequenceGenerator(random: Random(0));
      const hardPatterns = {SequencePattern.multiply2, SequencePattern.multiply3};

      for (var i = 0; i < 30; i++) {
        final puzzle = generator.generate(difficulty: PuzzleDifficulty.hard);
        final values = puzzle.sequence!
            .where((value) => value != '?')
            .map(int.parse)
            .toList();
        expect(_detectPattern(values), isIn(hardPatterns));
      }
    });

    test('options are unique and include correct answer', () {
      final generator = SequenceGenerator(random: Random(99));

      for (final difficulty in PuzzleDifficulty.values) {
        for (var i = 0; i < 10; i++) {
          final puzzle = generator.generate(difficulty: difficulty);
          expect(puzzle.options.toSet(), hasLength(4));
          expect(puzzle.options, contains(puzzle.correctAnswer));
        }
      }
    });
  });
}

SequencePattern? _detectPattern(List<int> values) {
  if (values.length < 2) return null;

  final addStep = values[1] - values[0];
  final isAdd = List.generate(values.length - 1, (index) {
    return values[index + 1] - values[index] == addStep;
  }).every((matches) => matches);

  if (isAdd && addStep == 1) return SequencePattern.add1;
  if (isAdd && addStep == 2) return SequencePattern.add2;
  if (isAdd && addStep == 3) return SequencePattern.add3;

  final isMultiply = List.generate(values.length - 1, (index) {
    return values[index] != 0 && values[index + 1] % values[index] == 0;
  }).every((matches) => matches);

  if (isMultiply && values[1] ~/ values[0] == 2) {
    return SequencePattern.multiply2;
  }
  if (isMultiply && values[1] ~/ values[0] == 3) {
    return SequencePattern.multiply3;
  }

  return null;
}
