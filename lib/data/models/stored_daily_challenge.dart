class StoredDailyChallengeCompletion {
  const StoredDailyChallengeCompletion({
    required this.challengeDate,
    required this.correctCount,
    required this.totalCount,
    required this.xpEarned,
    required this.completedAt,
  });

  final String challengeDate;
  final int correctCount;
  final int totalCount;
  final int xpEarned;
  final DateTime completedAt;
}
