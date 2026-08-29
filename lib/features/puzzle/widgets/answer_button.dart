import 'package:flutter/material.dart';

import '../../../theme/brainy_theme.dart';

enum AnswerState { idle, selected, correct, incorrect }

class AnswerButton extends StatelessWidget {
  const AnswerButton({
    super.key,
    required this.label,
    required this.state,
    required this.onPressed,
    required this.enabled,
  });

  final String label;
  final AnswerState state;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brainy = context.brainyTheme;

    final (background, border, foreground) = switch (state) {
      AnswerState.idle => (
          theme.colorScheme.surface,
          brainy.buttonBorder,
          theme.colorScheme.onSurface,
        ),
      AnswerState.selected => (
          theme.colorScheme.secondary.withValues(alpha: 0.12),
          theme.colorScheme.secondary,
          theme.colorScheme.secondary,
        ),
      AnswerState.correct => (
          theme.colorScheme.primary.withValues(alpha: 0.15),
          brainy.primaryDark,
          brainy.primaryDark,
        ),
      AnswerState.incorrect => (
          theme.colorScheme.error.withValues(alpha: 0.12),
          brainy.errorDark,
          brainy.errorDark,
        ),
    };

    return Material(
      color: background,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: enabled ? onPressed : null,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: border.withValues(alpha: 0.4)),
            boxShadow: [
              BoxShadow(
                color: border.withValues(alpha: enabled ? 1 : 0.4),
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: foreground,
                    ),
                  ),
                ),
                if (state == AnswerState.correct)
                  Icon(Icons.check_circle, color: brainy.primaryDark),
                if (state == AnswerState.incorrect)
                  Icon(Icons.cancel, color: brainy.errorDark),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
