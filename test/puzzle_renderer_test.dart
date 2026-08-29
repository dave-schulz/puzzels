import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/puzzle/generators/pattern_generator.dart';
import 'package:brainy/features/puzzle/data/sample_puzzles.dart';
import 'package:brainy/features/puzzle/models/puzzle_difficulty.dart';
import 'package:brainy/features/puzzle/models/puzzle_type.dart';
import 'package:brainy/features/puzzle/widgets/puzzle_renderer.dart';

void main() {
  testWidgets('PuzzleRenderer shows sequence puzzle', (tester) async {
    final puzzle = samplePuzzles.first;

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PuzzleRenderer(puzzle: puzzle))),
    );

    expect(find.text('What comes next?'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('?'), findsOneWidget);
  });

  testWidgets('PuzzleRenderer shows multiple choice puzzle', (tester) async {
    final puzzle = samplePuzzles.last;

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PuzzleRenderer(puzzle: puzzle))),
    );

    expect(find.text('Tom is taller than Lisa.'), findsOneWidget);
    expect(find.text('Who is shortest?'), findsOneWidget);
  });

  testWidgets('PuzzleRenderer shows pattern puzzle', (tester) async {
    final puzzle =
        PatternGenerator(random: Random(0)).generate(difficulty: PuzzleDifficulty.easy);

    await tester.pumpWidget(
      MaterialApp(home: Scaffold(body: PuzzleRenderer(puzzle: puzzle))),
    );

    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('What completes the pattern?'), findsOneWidget);
    expect(find.text('?'), findsOneWidget);
  });

  test('sample puzzles cover core types', () {
    final types = samplePuzzles.map((puzzle) => puzzle.type).toSet();

    expect(types, contains(PuzzleType.sequence));
    expect(types, contains(PuzzleType.multipleChoice));
    expect(samplePuzzles.length, greaterThanOrEqualTo(3));
  });
}
