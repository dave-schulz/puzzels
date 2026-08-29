import 'package:flutter/material.dart';

enum FeedbackType { correct, incorrect }

class PuzzleFeedback extends StatelessWidget {
  const PuzzleFeedback({
    super.key,
    required this.type,
    required this.onContinue,
    this.correctAnswer,
    this.continueLabel = 'Continue',
  });

  final FeedbackType type;
  final VoidCallback onContinue;
  final String? correctAnswer;
  final String continueLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCorrect = type == FeedbackType.correct;
    final backgroundColor =
        isCorrect ? theme.colorScheme.primary : theme.colorScheme.error;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: theme.colorScheme.onPrimary,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isCorrect ? 'Nice!' : 'Correct answer: $correctAnswer',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.surface,
                  foregroundColor: theme.colorScheme.secondary,
                ),
                onPressed: onContinue,
                child: Text(continueLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
