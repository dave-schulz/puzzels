import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../features/xp/xp_controller.dart';

final xpControllerProvider = ChangeNotifierProvider<XpController>((ref) {
  return XpController();
});

final totalXpProvider = Provider<int>((ref) {
  return ref.watch(xpControllerProvider).total;
});

final levelProvider = Provider<int>((ref) {
  return ref.watch(xpControllerProvider).level;
});
