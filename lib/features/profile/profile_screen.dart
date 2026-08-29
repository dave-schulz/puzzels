import 'package:flutter/material.dart';

import '../level/widgets/level_progress_bar.dart';
import '../xp/widgets/xp_badge.dart';
import '../xp/widgets/xp_scope.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final xpController = XpScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 36,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your profile',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: xpController,
              builder: (context, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    XpBadge(total: xpController.total),
                    const SizedBox(height: 16),
                    LevelProgressBar(totalXp: xpController.total),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              'Stats and settings will appear here.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
