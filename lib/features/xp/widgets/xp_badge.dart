import 'package:flutter/material.dart';

class XpBadge extends StatelessWidget {
  const XpBadge({
    super.key,
    required this.total,
  });

  final int total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.star,
          size: 20,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 6),
        Text(
          '$total XP',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
