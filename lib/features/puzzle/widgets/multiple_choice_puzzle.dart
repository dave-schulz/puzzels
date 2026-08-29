import 'package:flutter/material.dart';

import '../models/puzzle.dart';

class MultipleChoicePuzzle extends StatelessWidget {
  const MultipleChoicePuzzle({
    super.key,
    required this.puzzle,
  });

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statements = puzzle.statements ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final statement in statements) ...[
          Text(
            statement,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
        ],
        if (statements.isNotEmpty) const SizedBox(height: 12),
        Text(
          puzzle.prompt,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
