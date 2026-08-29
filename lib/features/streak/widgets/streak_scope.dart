import 'package:flutter/material.dart';

import '../streak_controller.dart';

class StreakScope extends InheritedNotifier<StreakController> {
  const StreakScope({
    super.key,
    required StreakController controller,
    required super.child,
  }) : super(notifier: controller);

  static StreakController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<StreakScope>();
    assert(scope != null, 'StreakScope not found in widget tree');
    return scope!.notifier!;
  }
}
