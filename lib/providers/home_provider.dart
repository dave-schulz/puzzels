import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/level/models/level_progress.dart';
import 'progress_provider.dart';
import 'streak_provider.dart';
import 'user_provider.dart';
import 'xp_provider.dart';

class HomeState {
  const HomeState({
    required this.displayName,
    required this.streak,
    required this.totalXp,
    required this.levelProgress,
  });

  final String displayName;
  final int streak;
  final int totalXp;
  final LevelProgress levelProgress;
}

final homeStateProvider = Provider<HomeState>((ref) {
  final profile = ref.watch(userProfileProvider);
  final streak = ref.watch(streakCountProvider);
  final totalXp = ref.watch(totalXpProvider);
  final levelProgress = ref.watch(levelProgressProvider);

  return HomeState(
    displayName: profile.displayName,
    streak: streak,
    totalXp: totalXp,
    levelProgress: levelProgress,
  );
});
