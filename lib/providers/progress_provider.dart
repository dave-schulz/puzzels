import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/level/level_calculator.dart';
import '../features/level/models/level_progress.dart';
import 'xp_provider.dart';

final levelProgressProvider = Provider<LevelProgress>((ref) {
  final totalXp = ref.watch(totalXpProvider);
  return LevelCalculator.progressFor(totalXp);
});
