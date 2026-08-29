import 'dart:math';

import '../models/puzzle.dart';
import '../models/puzzle_difficulty.dart';
import '../models/puzzle_type.dart';

class _HeightChain {
  const _HeightChain({
    required this.statements,
    required this.prompt,
    required this.answer,
    required this.options,
  });

  final List<String> statements;
  final String prompt;
  final String answer;
  final List<String> options;
}

class LogicPuzzleGenerator {
  LogicPuzzleGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  static const _names = ['Tom', 'Lisa', 'Mark', 'Anna', 'Sam', 'Emma'];

  Puzzle generate({required PuzzleDifficulty difficulty}) {
    final chain = _buildChain(difficulty);
    final options = [...chain.options]..shuffle(_random);
    final correctIndex = options.indexOf(chain.answer);

    return Puzzle(
      id: 'logic-${DateTime.now().microsecondsSinceEpoch}',
      type: PuzzleType.multipleChoice,
      difficulty: difficulty,
      prompt: chain.prompt,
      statements: chain.statements,
      options: options,
      correctIndex: correctIndex,
    );
  }

  _HeightChain _buildChain(PuzzleDifficulty difficulty) {
    return switch (difficulty) {
      PuzzleDifficulty.easy => _twoPersonChain(),
      PuzzleDifficulty.medium => _threePersonChain(tricky: false),
      PuzzleDifficulty.hard => _threePersonChain(tricky: true),
    };
  }

  _HeightChain _twoPersonChain() {
    final names = _pickNames(2);
    final taller = names[0];
    final shorter = names[1];
    final askTaller = _random.nextBool();

    return _HeightChain(
      statements: ['$taller is taller than $shorter.'],
      prompt: askTaller ? 'Who is taller?' : 'Who is shorter?',
      answer: askTaller ? taller : shorter,
      options: [taller, shorter],
    );
  }

  _HeightChain _threePersonChain({required bool tricky}) {
    final names = _pickNames(3);
    final tallest = names[0];
    final middle = names[1];
    final shortest = names[2];

    final statements = [
      '$tallest is taller than $middle.',
      '$middle is taller than $shortest.',
    ];

    if (tricky) {
      final prompts = [
        ('Who is in the middle?', middle),
        ('Who is second tallest?', middle),
      ];
      final selected = prompts[_random.nextInt(prompts.length)];
      return _HeightChain(
        statements: statements,
        prompt: selected.$1,
        answer: selected.$2,
        options: names,
      );
    }

    final prompts = [
      ('Who is shortest?', shortest),
      ('Who is tallest?', tallest),
    ];
    final selected = prompts[_random.nextInt(prompts.length)];

    return _HeightChain(
      statements: statements,
      prompt: selected.$1,
      answer: selected.$2,
      options: names,
    );
  }

  List<String> _pickNames(int count) {
    final pool = [..._names]..shuffle(_random);
    return pool.take(count).toList();
  }
}
