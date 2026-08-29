import 'dart:math';

import '../models/pattern_cell.dart';
import '../models/pattern_grid.dart';
import '../models/puzzle.dart';
import '../models/puzzle_difficulty.dart';
import '../models/puzzle_type.dart';
import 'pattern_kind.dart';

class PatternGenerator {
  PatternGenerator({Random? random}) : _random = random ?? Random();

  final Random _random;

  static const _optionCount = 4;
  static const _distractorLabels = ['🔲', '◼️', '◻️', '▪️'];

  Puzzle generate({required PuzzleDifficulty difficulty}) {
    final kind = _randomKind(difficulty);
    final size = _gridSize(difficulty);
    final filledGrid = _buildGrid(kind, size);
    final hideAt = _pickHiddenCell(size);
    final correct = filledGrid[hideAt.row][hideAt.column];

    final displayGrid = _hideCell(filledGrid, hideAt.row, hideAt.column);
    final options = _buildOptions(correct);
    final correctIndex = options.indexOf(correct.label);

    return Puzzle(
      id: 'pattern-${DateTime.now().microsecondsSinceEpoch}',
      type: PuzzleType.pattern,
      difficulty: difficulty,
      prompt: 'What completes the pattern?',
      patternGrid: PatternGrid(rows: displayGrid),
      options: options,
      correctIndex: correctIndex,
    );
  }

  PatternKind _randomKind(PuzzleDifficulty difficulty) {
    final kinds = switch (difficulty) {
      PuzzleDifficulty.easy => const [PatternKind.checkerboard],
      PuzzleDifficulty.medium => const [
          PatternKind.checkerboard,
          PatternKind.rowStripes,
          PatternKind.columnStripes,
        ],
      PuzzleDifficulty.hard => const [
          PatternKind.diagonal,
          PatternKind.frame,
          PatternKind.checkerboard,
        ],
    };
    return kinds[_random.nextInt(kinds.length)];
  }

  int _gridSize(PuzzleDifficulty difficulty) {
    return switch (difficulty) {
      PuzzleDifficulty.easy => 3,
      PuzzleDifficulty.medium => 3,
      PuzzleDifficulty.hard => 4,
    };
  }

  List<List<PatternCellState>> _buildGrid(PatternKind kind, int size) {
    return switch (kind) {
      PatternKind.checkerboard => _checkerboard(size),
      PatternKind.rowStripes => _rowStripes(size),
      PatternKind.columnStripes => _columnStripes(size),
      PatternKind.diagonal => _diagonal(size),
      PatternKind.frame => _frame(size),
    };
  }

  List<List<PatternCellState>> _checkerboard(int size) {
    final invert = _random.nextBool();
    return List.generate(size, (row) {
      return List.generate(size, (column) {
        final isFilled = (row + column).isEven;
        return _cell(isFilled != invert);
      });
    });
  }

  List<List<PatternCellState>> _rowStripes(int size) {
    return List.generate(size, (row) {
      final isFilled = row.isEven;
      return List.generate(size, (_) => _cell(isFilled));
    });
  }

  List<List<PatternCellState>> _columnStripes(int size) {
    return List.generate(size, (row) {
      return List.generate(size, (column) {
        return _cell(column.isEven);
      });
    });
  }

  List<List<PatternCellState>> _diagonal(int size) {
    final useAntiDiagonal = _random.nextBool();
    return List.generate(size, (row) {
      return List.generate(size, (column) {
        final onDiagonal = useAntiDiagonal
            ? row + column == size - 1
            : row == column;
        return _cell(onDiagonal);
      });
    });
  }

  List<List<PatternCellState>> _frame(int size) {
    return List.generate(size, (row) {
      return List.generate(size, (column) {
        final isBorder =
            row == 0 || row == size - 1 || column == 0 || column == size - 1;
        return _cell(isBorder);
      });
    });
  }

  PatternCellState _cell(bool filled) {
    return filled ? PatternCellState.filled : PatternCellState.empty;
  }

  ({int row, int column}) _pickHiddenCell(int size) {
    final row = _random.nextInt(size);
    final column = _random.nextInt(size);
    return (row: row, column: column);
  }

  List<List<PatternCellState>> _hideCell(
    List<List<PatternCellState>> grid,
    int row,
    int column,
  ) {
    return [
      for (var r = 0; r < grid.length; r++)
        [
          for (var c = 0; c < grid[r].length; c++)
            if (r == row && c == column)
              PatternCellState.unknown
            else
              grid[r][c],
        ],
    ];
  }

  List<String> _buildOptions(PatternCellState correct) {
    final options = <String>{correct.label};

    options.add(
      correct == PatternCellState.filled
          ? PatternCellState.empty.label
          : PatternCellState.filled.label,
    );

    for (final label in _distractorLabels) {
      if (options.length >= _optionCount) break;
      options.add(label);
    }

    final result = options.toList()..shuffle(_random);
    return result.take(_optionCount).toList();
  }
}
