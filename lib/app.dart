import 'package:flutter/material.dart';

import 'features/streak/widgets/streak_scope.dart';
import 'features/streak/streak_controller.dart';
import 'features/xp/widgets/xp_scope.dart';
import 'features/xp/xp_controller.dart';
import 'theme/app_theme.dart';
import 'widgets/app_shell.dart';

class BrainyApp extends StatefulWidget {
  const BrainyApp({super.key});

  @override
  State<BrainyApp> createState() => _BrainyAppState();
}

class _BrainyAppState extends State<BrainyApp> {
  final _xpController = XpController();
  final _streakController = StreakController();

  @override
  void dispose() {
    _xpController.dispose();
    _streakController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreakScope(
      controller: _streakController,
      child: XpScope(
        controller: _xpController,
        child: MaterialApp(
          title: 'Brainy',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          home: const AppShell(),
        ),
      ),
    );
  }
}
