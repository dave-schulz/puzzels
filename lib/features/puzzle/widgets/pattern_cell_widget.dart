import 'package:flutter/material.dart';

import '../../../theme/brainy_theme.dart';
import '../models/pattern_cell.dart';

class PatternCellWidget extends StatelessWidget {
  const PatternCellWidget({
    super.key,
    required this.state,
    this.size = 56,
  });

  final PatternCellState state;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brainy = context.brainyTheme;

    final Widget? child = switch (state) {
      PatternCellState.unknown => Text(
          '?',
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      _ => null,
    };

    final (background, border) = switch (state) {
      PatternCellState.filled => (
          const Color(0xFF1E293B),
          const Color(0xFF334155),
        ),
      PatternCellState.empty => (
          theme.colorScheme.surfaceContainerHighest,
          theme.colorScheme.outlineVariant,
        ),
      PatternCellState.unknown => (
          theme.colorScheme.primary.withValues(alpha: 0.12),
          theme.colorScheme.primary,
        ),
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: state == PatternCellState.unknown
              ? brainy.primaryDark
              : border,
          width: state == PatternCellState.unknown ? 2 : 1,
        ),
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
