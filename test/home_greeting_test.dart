import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/home/home_greeting.dart';

void main() {
  group('homeGreeting', () {
    test('returns morning before noon', () {
      expect(homeGreeting(DateTime(2026, 1, 1, 9)), 'Good morning');
    });

    test('returns afternoon before evening', () {
      expect(homeGreeting(DateTime(2026, 1, 1, 14)), 'Good afternoon');
    });

    test('returns evening at night', () {
      expect(homeGreeting(DateTime(2026, 1, 1, 21)), 'Good evening');
    });
  });
}
