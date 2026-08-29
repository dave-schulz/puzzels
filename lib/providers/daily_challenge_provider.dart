import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/daily_challenge/daily_challenge_date.dart';
import '../features/daily_challenge/daily_challenge_generator.dart';
import '../features/lesson/models/lesson.dart';
import 'database_provider.dart';
import 'skills_provider.dart';
import 'user_provider.dart';

final dailyChallengeGeneratorProvider = Provider<DailyChallengeGenerator>(
  (ref) => DailyChallengeGenerator(),
);

final todayDailyLessonProvider = Provider<Lesson>((ref) {
  final skills = ref.watch(skillsProvider);
  return ref.watch(dailyChallengeGeneratorProvider).generateForDate(
        DateTime.now(),
        skills: skills,
      );
});

class DailyChallengeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void restore(bool completedToday) {
    state = completedToday;
  }

  Future<void> refreshForToday() async {
    final userId = ref.read(currentUserIdProvider);
    final dateKey = dailyChallengeDateKey(DateTime.now());
    final completion = await ref
        .read(progressRepositoryProvider)
        .getDailyChallengeCompletion(
          userId: userId,
          challengeDate: dateKey,
        );
    state = completion != null;
  }

  void markCompletedToday() {
    state = true;
  }
}

final dailyChallengeCompletedProvider =
    NotifierProvider<DailyChallengeNotifier, bool>(
  DailyChallengeNotifier.new,
);
