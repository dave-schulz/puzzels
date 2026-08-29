import 'package:flutter_test/flutter_test.dart';

import 'package:brainy/features/daily_challenge/daily_challenge_generator.dart';
import 'package:brainy/features/skill/models/user_skills.dart';

void main() {
  group('DailyChallengeGenerator', () {
    final generator = DailyChallengeGenerator();
    final date = DateTime(2026, 8, 30);
    const skills = UserSkills.defaults;

    test('generates five puzzles for a date', () {
      final lesson = generator.generateForDate(date, skills: skills);

      expect(lesson.puzzles, hasLength(5));
      expect(lesson.isDailyChallenge, isTrue);
      expect(lesson.id, 'daily-2026-08-30');
    });

    test('generates the same puzzles for the same date', () {
      final first = generator.generateForDate(date, skills: skills);
      final second = generator.generateForDate(date, skills: skills);

      expect(
        first.puzzles.map((puzzle) => puzzle.correctAnswer).toList(),
        second.puzzles.map((puzzle) => puzzle.correctAnswer).toList(),
      );
    });

    test('generates different puzzles for different dates', () {
      final today = generator.generateForDate(date, skills: skills);
      final tomorrow = generator.generateForDate(
        DateTime(2026, 8, 31),
        skills: skills,
      );

      expect(
        today.puzzles.first.correctAnswer,
        isNot(tomorrow.puzzles.first.correctAnswer),
      );
    });
  });
}
