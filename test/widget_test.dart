import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/app.dart';
import 'package:brainy/data/repositories/local_progress_repository.dart';
import 'package:brainy/providers/database_provider.dart';

void main() {
  testWidgets('App starts on home screen', (WidgetTester tester) async {
    final database = await createTestAppDatabase();
    final repository = LocalProgressRepository(database);
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          progressRepositoryProvider.overrideWithValue(repository),
        ],
        child: const BrainyApp(),
      ),
    );

    expect(find.textContaining('Davey'), findsOneWidget);
    expect(find.text('Continue training'), findsOneWidget);
    expect(find.text('Daily Challenge'), findsOneWidget);
  });
}
