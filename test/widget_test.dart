import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/main.dart';

void main() {
  testWidgets('App starts with home tab', (WidgetTester tester) async {
    await tester.pumpWidget(const BrainyApp());

    expect(find.text('Brainy'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });
}
