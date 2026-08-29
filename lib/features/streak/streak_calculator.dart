import 'models/streak_update.dart';

abstract final class StreakCalculator {
  static DateTime dateOnly(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static int daysBetween(DateTime from, DateTime to) {
    return dateOnly(to).difference(dateOnly(from)).inDays;
  }

  static bool playedToday({
    required DateTime? lastPlayDate,
    required DateTime now,
  }) {
    if (lastPlayDate == null) return false;
    return dateOnly(lastPlayDate) == dateOnly(now);
  }

  static bool playedYesterday({
    required DateTime? lastPlayDate,
    required DateTime now,
  }) {
    if (lastPlayDate == null) return false;
    return daysBetween(lastPlayDate, now) == 1;
  }

  static StreakUpdate recordPlay({
    required int currentStreak,
    required DateTime? lastPlayDate,
    required DateTime now,
  }) {
    final today = dateOnly(now);

    if (lastPlayDate == null) {
      return StreakUpdate(streak: 1, lastPlayDate: today);
    }

    final last = dateOnly(lastPlayDate);
    if (last == today) {
      return StreakUpdate(streak: currentStreak, lastPlayDate: last);
    }

    if (daysBetween(last, today) == 1) {
      return StreakUpdate(
        streak: currentStreak + 1,
        lastPlayDate: today,
      );
    }

    return StreakUpdate(streak: 1, lastPlayDate: today);
  }
}
