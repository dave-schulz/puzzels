import 'package:flutter/material.dart';

import '../../../theme/brainy_theme.dart';

class PuzzleProgress extends StatelessWidget {
  const PuzzleProgress({
    super.key,
    required this.total,
    required this.completed,
  });

  final int total;
  final int completed;

  @override
  Widget build(BuildContext context) {
    final brainy = context.brainyTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: List.generate(total, (index) {
          final isCompleted = index < completed;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: index < total - 1 ? 8 : 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 14,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? brainy.progressActive
                      : brainy.progressInactive,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
