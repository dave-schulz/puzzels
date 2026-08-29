import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/puzzle/data/sample_puzzles.dart';
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

  test('sample puzzles cover both types', () {
    final types = samplePuzzles.map((puzzle) => puzzle.type).toSet();

    expect(types, contains(PuzzleType.sequence));
    expect(types, contains(PuzzleType.multipleChoice));
    expect(samplePuzzles.length, greaterThanOrEqualTo(3));
  });
}
