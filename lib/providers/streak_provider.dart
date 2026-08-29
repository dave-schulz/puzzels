import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../features/streak/streak_controller.dart';

final streakControllerProvider = ChangeNotifierProvider<StreakController>((ref) {
  return StreakController();
});

final streakCountProvider = Provider<int>((ref) {
  return ref.watch(streakControllerProvider).streak;
});
