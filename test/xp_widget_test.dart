import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/xp/widgets/xp_badge.dart';

void main() {
  testWidgets('XpBadge displays total XP', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: XpBadge(total: 820),
        ),
      ),
    );

    expect(find.text('820 XP'), findsOneWidget);
  });
}
