import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/app.dart';

void main() {
  testWidgets('App starts on home screen', (WidgetTester tester) async {
    await tester.pumpWidget(const BrainyApp());

    expect(find.text('Good evening 👋'), findsOneWidget);
    expect(find.text('Start'), findsOneWidget);
  });
}
