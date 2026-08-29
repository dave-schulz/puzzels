import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/puzzle/generators/pattern_generator.dart';
import 'package:brainy/features/puzzle/models/pattern_cell.dart';
import 'package:brainy/features/puzzle/models/puzzle_difficulty.dart';
import 'package:brainy/features/puzzle/models/puzzle_type.dart';

void main() {
  group('PatternGenerator', () {
    test('generates valid pattern puzzle', () {
      final generator = PatternGenerator(random: Random(1));
      final puzzle = generator.generate(difficulty: PuzzleDifficulty.easy);

      expect(puzzle.type, PuzzleType.pattern);
      expect(puzzle.patternGrid, isNotNull);
      expect(puzzle.options, hasLength(4));
      expect(puzzle.options, contains(puzzle.correctAnswer));
    });

    test('easy puzzles use 3x3 checkerboard grid', () {
      final generator = PatternGenerator(random: Random(0));
      final puzzle = generator.generate(difficulty: PuzzleDifficulty.easy);
      final grid = puzzle.patternGrid!;

      expect(grid.rowCount, 3);
      expect(grid.columnCount, 3);

      var unknownCount = 0;
      for (var row = 0; row < grid.rowCount; row++) {
        for (var column = 0; column < grid.columnCount; column++) {
          if (grid.cellAt(row, column) == PatternCellState.unknown) {
            unknownCount++;
          }
        }
      }
      expect(unknownCount, 1);
    });

    test('hard puzzles use 4x4 grid', () {
      final generator = PatternGenerator(random: Random(2));
      final puzzle = generator.generate(difficulty: PuzzleDifficulty.hard);
      final grid = puzzle.patternGrid!;

      expect(grid.rowCount, 4);
      expect(grid.columnCount, 4);
    });

    test('options are unique', () {
      final generator = PatternGenerator(random: Random(3));

      for (var i = 0; i < 20; i++) {
        final puzzle = generator.generate(difficulty: PuzzleDifficulty.medium);
        expect(puzzle.options.toSet(), hasLength(4));
      }
    });
  });
}
