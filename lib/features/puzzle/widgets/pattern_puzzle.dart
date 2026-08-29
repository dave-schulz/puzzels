import 'package:flutter/material.dart';

import '../models/puzzle.dart';
import 'pattern_cell_widget.dart';

class PatternPuzzle extends StatelessWidget {
  const PatternPuzzle({
    super.key,
    required this.puzzle,
  });

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final grid = puzzle.patternGrid;
    if (grid == null) return const SizedBox.shrink();

    final cellSize = grid.columnCount > 3 ? 48.0 : 56.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.92 + (0.08 * value),
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            puzzle.prompt,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                for (var row = 0; row < grid.rowCount; row++) ...[
                  if (row > 0) const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var column = 0; column < grid.columnCount; column++) ...[
                        if (column > 0) const SizedBox(width: 8),
                        PatternCellWidget(
                          state: grid.cellAt(row, column),
                          size: cellSize,
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
