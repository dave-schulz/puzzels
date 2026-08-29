import 'package:flutter/material.dart';

import '../models/puzzle.dart';

class SequencePuzzle extends StatelessWidget {
  const SequencePuzzle({
    super.key,
    required this.puzzle,
  });

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sequence = puzzle.sequence ?? const [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          puzzle.prompt,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (var i = 0; i < sequence.length; i++) ...[
              if (i > 0)
                Text(
                  '→',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              _SequenceItem(value: sequence[i]),
            ],
          ],
        ),
      ],
    );
  }
}

class _SequenceItem extends StatelessWidget {
  const _SequenceItem({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnknown = value == '?';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isUnknown
            ? theme.colorScheme.primary.withValues(alpha: 0.12)
            : theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnknown
              ? theme.colorScheme.primary
              : theme.colorScheme.outlineVariant,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: isUnknown
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
