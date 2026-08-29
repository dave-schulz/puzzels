import 'package:flutter/material.dart';

import '../xp_controller.dart';

class XpScope extends InheritedNotifier<XpController> {
  const XpScope({
    super.key,
    required XpController controller,
    required super.child,
  }) : super(notifier: controller);

  static XpController of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<XpScope>();
    assert(scope != null, 'XpScope not found in widget tree');
    return scope!.notifier!;
  }
}
