import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'providers/database_provider.dart';
import 'providers/progress_persistence.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await createAppDatabase();
  final container = ProviderContainer(
    overrides: [
      appDatabaseProvider.overrideWithValue(database),
    ],
  );
  await hydratePersistedProgress(container);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const BrainyApp(),
    ),
  );
}
