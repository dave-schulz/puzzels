class LessonResult {
  const LessonResult({
    required this.correctCount,
    required this.totalCount,
    required this.xpEarned,
  });

  final int correctCount;
  final int totalCount;
  final int xpEarned;

  int get starCount => correctCount;

  double get accuracy =>
      totalCount == 0 ? 0 : correctCount / totalCount;
}
