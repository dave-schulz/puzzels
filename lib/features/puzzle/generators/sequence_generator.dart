import 'dart:math';

import '../models/puzzle.dart';
import '../models/puzzle_type.dart';
import 'sequence_pattern.dart';

class SequenceGenerator {
  SequenceGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  static const _visibleTerms = 4;
  static const _optionCount = 4;

  Puzzle generate() {
    final pattern = _randomPattern();
    final start = _randomStart(pattern);
    final terms = _buildTerms(start, pattern);
    final correct = terms.last;
    final sequence = [
      ...terms.sublist(0, terms.length - 1).map((value) => '$value'),
      '?',
    ];
    final options = _buildOptions(correct, pattern);
    final correctIndex = options.indexOf('$correct');

    return Puzzle(
      id: 'seq-${DateTime.now().microsecondsSinceEpoch}',
      type: PuzzleType.sequence,
      prompt: 'What comes next?',
      sequence: sequence,
      options: options,
      correctIndex: correctIndex,
    );
  }

  List<Puzzle> generateSession({int count = 5}) {
    return List.generate(count, (_) => generate());
  }

  SequencePattern _randomPattern() {
    const patterns = SequencePattern.values;
    return patterns[_random.nextInt(patterns.length)];
  }

  int _randomStart(SequencePattern pattern) {
    if (pattern.isMultiply) {
      return _random.nextInt(5) + 2;
    }
    return _random.nextInt(18) + 2;
  }

  List<int> _buildTerms(int start, SequencePattern pattern) {
    final terms = <int>[start];
    while (terms.length < _visibleTerms) {
      terms.add(pattern.next(terms.last));
    }
    return [...terms, pattern.next(terms.last)];
  }

  List<String> _buildOptions(int correct, SequencePattern pattern) {
    final distractors = <int>{};

    void tryAdd(int value) {
      if (value > 0 && value != correct) {
        distractors.add(value);
      }
    }

    tryAdd(correct + 1);
    tryAdd(correct - 1);
    tryAdd(correct + 2);
    tryAdd(correct - 2);

    if (pattern.isMultiply) {
      if (correct.isEven) {
        tryAdd(correct ~/ 2);
      }
      tryAdd(correct + 3);
      tryAdd(correct - 3);
    } else {
      final step = switch (pattern) {
        SequencePattern.add1 => 1,
        SequencePattern.add2 => 2,
        SequencePattern.add3 => 3,
        _ => 1,
      };
      tryAdd(correct + step);
      tryAdd(correct - step);
      tryAdd(correct + step * 2);
      tryAdd(correct - step * 2);
    }

    var offset = 3;
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
