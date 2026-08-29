import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'widgets/app_shell.dart';

class BrainyApp extends StatelessWidget {
  const BrainyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brainy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const AppShell(),
    );
  }
}
