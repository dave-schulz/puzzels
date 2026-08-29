String dailyChallengeDateKey(DateTime date) {
  return '${date.year}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';
}

int dailyChallengeSeedForDate(DateTime date) {
  return dailyChallengeDateKey(date).hashCode;
}
