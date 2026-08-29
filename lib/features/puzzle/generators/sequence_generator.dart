import 'dart:math';

import '../models/puzzle.dart';
import '../models/puzzle_difficulty.dart';
import '../models/puzzle_type.dart';
import 'sequence_pattern.dart';

class SequenceGenerator {
  SequenceGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  static const _visibleTerms = 4;
  static const _optionCount = 4;

  static const defaultSessionDifficulties = <PuzzleDifficulty>[
    PuzzleDifficulty.easy,
    PuzzleDifficulty.easy,
    PuzzleDifficulty.medium,
    PuzzleDifficulty.medium,
    PuzzleDifficulty.hard,
  ];

  Puzzle generate({required PuzzleDifficulty difficulty}) {
    final pattern = _randomPattern(difficulty);
    final start = _randomStart(difficulty, pattern);
    final terms = _buildTerms(start, pattern);
    final correct = terms.last;
    final sequence = [
      ...terms.sublist(0, terms.length - 1).map((value) => '$value'),
      '?',
    ];
    final options = _buildOptions(correct, pattern, difficulty);
    final correctIndex = options.indexOf('$correct');

    return Puzzle(
      id: 'seq-${DateTime.now().microsecondsSinceEpoch}',
      type: PuzzleType.sequence,
      difficulty: difficulty,
      prompt: 'What comes next?',
      sequence: sequence,
      options: options,
      correctIndex: correctIndex,
    );
  }

  List<Puzzle> generateSession({
    List<PuzzleDifficulty> difficulties = defaultSessionDifficulties,
  }) {
    return difficulties.map((difficulty) => generate(difficulty: difficulty)).toList();
  }

  SequencePattern _randomPattern(PuzzleDifficulty difficulty) {
    final patterns = _patternsFor(difficulty);
    return patterns[_random.nextInt(patterns.length)];
  }

  List<SequencePattern> _patternsFor(PuzzleDifficulty difficulty) {
    return switch (difficulty) {
      PuzzleDifficulty.easy => const [
          SequencePattern.add1,
          SequencePattern.add2,
        ],
      PuzzleDifficulty.medium => const [
          SequencePattern.add3,
          SequencePattern.multiply2,
        ],
      PuzzleDifficulty.hard => const [
          SequencePattern.multiply2,
          SequencePattern.multiply3,
        ],
    };
  }

  int _randomStart(PuzzleDifficulty difficulty, SequencePattern pattern) {
    if (pattern.isMultiply) {
      return switch (difficulty) {
        PuzzleDifficulty.easy => _random.nextInt(3) + 2,
        PuzzleDifficulty.medium => _random.nextInt(4) + 2,
        PuzzleDifficulty.hard => _random.nextInt(5) + 2,
      };
    }

    return switch (difficulty) {
      PuzzleDifficulty.easy => _random.nextInt(10) + 2,
      PuzzleDifficulty.medium => _random.nextInt(16) + 4,
      PuzzleDifficulty.hard => _random.nextInt(20) + 5,
    };
  }

  List<int> _buildTerms(int start, SequencePattern pattern) {
    final terms = <int>[start];
    while (terms.length < _visibleTerms) {
      terms.add(pattern.next(terms.last));
    }
    return [...terms, pattern.next(terms.last)];
  }

  List<String> _buildOptions(
    int correct,
    SequencePattern pattern,
    PuzzleDifficulty difficulty,
  ) {
    final distractors = <int>{};

    void tryAdd(int value) {
      if (value > 0 && value != correct) {
        distractors.add(value);
      }
    }

    final closeOffset = switch (difficulty) {
      PuzzleDifficulty.easy => 2,
      PuzzleDifficulty.medium => 3,
      PuzzleDifficulty.hard => 1,
    };

    for (var offset = 1; offset <= closeOffset; offset++) {
      tryAdd(correct + offset);
      tryAdd(correct - offset);
    }

    if (pattern.isMultiply) {
      if (correct.isEven) {
        tryAdd(correct ~/ 2);
      }
      tryAdd(correct + pattern.next(1) - 1);
    } else {
      final step = switch (pattern) {
        SequencePattern.add1 => 1,
        SequencePattern.add2 => 2,
        SequencePattern.add3 => 3,
        _ => 1,
      };
      tryAdd(correct + step);
      tryAdd(correct - step);
      if (difficulty != PuzzleDifficulty.easy) {
        tryAdd(correct + step * 2);
        tryAdd(correct - step * 2);
      }
    }

    var offset = closeOffset + 1;
    while (distractors.length < _optionCount - 1 && offset < 25) {
      tryAdd(correct + offset);
      tryAdd(correct - offset);
      offset++;
    }

    final options = [...distractors.take(_optionCount - 1), correct].toList()
      ..shuffle(_random);

    return options.map((value) => '$value').toList();
  }
}
