import 'dart:math';

import '../lesson/generators/lesson_generator.dart';
import '../lesson/models/lesson.dart';
import '../puzzle/generators/logic_puzzle_generator.dart';
import '../puzzle/generators/pattern_generator.dart';
import '../puzzle/generators/sequence_generator.dart';
import '../skill/models/user_skills.dart';
import 'daily_challenge_constants.dart';
import 'daily_challenge_date.dart';

class DailyChallengeGenerator {
  Lesson generateForDate(
    DateTime date, {
    UserSkills skills = UserSkills.defaults,
  }) {
    final random = Random(dailyChallengeSeedForDate(date));
    final generator = LessonGenerator(
      sequenceGenerator: SequenceGenerator(random: random),
      logicGenerator: LogicPuzzleGenerator(random: random),
      patternGenerator: PatternGenerator(random: random),
    );

    final puzzles = generator.generatePuzzles(
      plan: LessonGenerator.planForSkills(skills),
    );

    return Lesson(
      id: 'daily-${dailyChallengeDateKey(date)}',
      title: DailyChallengeConstants.title,
      puzzles: puzzles,
      isDailyChallenge: true,
    );
  }
}
