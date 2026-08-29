import 'package:flutter/material.dart';

import '../models/puzzle.dart';
import '../models/puzzle_type.dart';
import 'multiple_choice_puzzle.dart';
import 'sequence_puzzle.dart';

class PuzzleRenderer extends StatelessWidget {
  const PuzzleRenderer({
    super.key,
    required this.puzzle,
  });

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    return switch (puzzle.type) {
      PuzzleType.sequence => SequencePuzzle(puzzle: puzzle),
      PuzzleType.multipleChoice => MultipleChoicePuzzle(puzzle: puzzle),
    };
  }
}
