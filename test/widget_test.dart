import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/app.dart';

void main() {
  testWidgets('App starts on home screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: BrainyApp(),
      ),
    );

    expect(find.textContaining('Good evening'), findsOneWidget);
    expect(find.textContaining('Davey'), findsOneWidget);
    expect(find.text('Continue training'), findsOneWidget);
    expect(find.text('Daily Challenge'), findsOneWidget);
  });
}
