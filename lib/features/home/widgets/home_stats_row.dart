import 'package:flutter/material.dart';

import '../../streak/widgets/streak_badge.dart';
import '../../xp/widgets/xp_badge.dart';

class HomeStatsRow extends StatelessWidget {
  const HomeStatsRow({
    super.key,
    required this.streak,
    required this.totalXp,
  });

  final int streak;
  final int totalXp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (streak > 0) StreakBadge(streak: streak),
        if (streak > 0) const Spacer(),
        XpBadge(total: totalXp),
      ],
    );
  }
}
