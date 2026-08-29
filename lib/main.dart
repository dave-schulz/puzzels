import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'shared/widgets/app_shell.dart';

void main() {
  runApp(const BrainyApp());
}

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
