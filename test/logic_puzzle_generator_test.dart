import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/puzzle/generators/logic_puzzle_generator.dart';
import 'package:brainy/features/puzzle/models/puzzle_difficulty.dart';
import 'package:brainy/features/puzzle/models/puzzle_type.dart';

void main() {
  group('LogicPuzzleGenerator', () {
    test('generates valid multiple choice puzzle', () {
      final generator = LogicPuzzleGenerator(random: Random(1));
      final puzzle = generator.generate(difficulty: PuzzleDifficulty.medium);

      expect(puzzle.type, PuzzleType.multipleChoice);
      expect(puzzle.statements, isNotEmpty);
      expect(puzzle.options, hasLength(3));
      expect(puzzle.options, contains(puzzle.correctAnswer));
    });

    test('easy puzzles use two people', () {
      final generator = LogicPuzzleGenerator(random: Random(0));

      for (var i = 0; i < 10; i++) {
        final puzzle = generator.generate(difficulty: PuzzleDifficulty.easy);
        expect(puzzle.statements, hasLength(1));
        expect(puzzle.options, hasLength(2));
      }
    });

    test('medium puzzle can produce shortest question', () {
      final generator = LogicPuzzleGenerator(random: Random(2));
      final puzzle = generator.generate(difficulty: PuzzleDifficulty.medium);

      expect(
        puzzle.prompt == 'Who is shortest?' ||
            puzzle.prompt == 'Who is tallest?',
        isTrue,
      );
    });

    test('hard puzzles ask for middle person', () {
      final generator = LogicPuzzleGenerator(random: Random(0));
      final puzzle = generator.generate(difficulty: PuzzleDifficulty.hard);

      expect(
        puzzle.prompt == 'Who is in the middle?' ||
            puzzle.prompt == 'Who is second tallest?',
        isTrue,
      );
    });
  });
}
