import '../../puzzle/generators/logic_puzzle_generator.dart';
import '../../puzzle/generators/pattern_generator.dart';
import '../../puzzle/generators/sequence_generator.dart';
import '../../puzzle/models/puzzle.dart';
import '../../puzzle/models/puzzle_difficulty.dart';
import '../../skill/models/user_skills.dart';
import '../../skill/skill_calculator.dart';
import '../models/lesson.dart';

enum LessonPuzzleKind {
  sequence,
  logic,
  pattern,
}

class LessonPuzzlePlan {
  const LessonPuzzlePlan({
    required this.kind,
    required this.difficulty,
  });

  final LessonPuzzleKind kind;
  final PuzzleDifficulty difficulty;
}

class LessonGenerator {
  LessonGenerator({
    SequenceGenerator? sequenceGenerator,
    LogicPuzzleGenerator? logicGenerator,
    PatternGenerator? patternGenerator,
  })  : _sequenceGenerator = sequenceGenerator ?? SequenceGenerator(),
        _logicGenerator = logicGenerator ?? LogicPuzzleGenerator(),
        _patternGenerator = patternGenerator ?? PatternGenerator();

  final SequenceGenerator _sequenceGenerator;
  final LogicPuzzleGenerator _logicGenerator;
  final PatternGenerator _patternGenerator;

  static const defaultPlan = <LessonPuzzlePlan>[
    LessonPuzzlePlan(
      kind: LessonPuzzleKind.sequence,
      difficulty: PuzzleDifficulty.easy,
    ),
    LessonPuzzlePlan(
      kind: LessonPuzzleKind.pattern,
      difficulty: PuzzleDifficulty.easy,
    ),
    LessonPuzzlePlan(
      kind: LessonPuzzleKind.logic,
      difficulty: PuzzleDifficulty.medium,
    ),
    LessonPuzzlePlan(
      kind: LessonPuzzleKind.sequence,
      difficulty: PuzzleDifficulty.medium,
    ),
    LessonPuzzlePlan(
      kind: LessonPuzzleKind.sequence,
      difficulty: PuzzleDifficulty.hard,
    ),
  ];

  static const adaptiveKinds = <LessonPuzzleKind>[
    LessonPuzzleKind.sequence,
    LessonPuzzleKind.pattern,
    LessonPuzzleKind.logic,
    LessonPuzzleKind.sequence,
    LessonPuzzleKind.sequence,
  ];

  static List<LessonPuzzlePlan> planForSkills(UserSkills skills) {
    return [
      for (final kind in adaptiveKinds)
        LessonPuzzlePlan(
          kind: kind,
          difficulty: switch (kind) {
            LessonPuzzleKind.sequence =>
              SkillCalculator.difficultyFor(skills.sequence),
            LessonPuzzleKind.logic =>
              SkillCalculator.difficultyFor(skills.logic),
            LessonPuzzleKind.pattern =>
              SkillCalculator.difficultyFor(skills.pattern),
          },
        ),
    ];
  }

  Lesson generate({
    String title = 'Logic Training',
    UserSkills skills = UserSkills.defaults,
  }) {
    final puzzles = generatePuzzles(plan: planForSkills(skills));

    return Lesson(
      id: 'lesson-${DateTime.now().microsecondsSinceEpoch}',
      title: title,
      puzzles: puzzles,
    );
  }

  List<Puzzle> generatePuzzles({
    List<LessonPuzzlePlan> plan = defaultPlan,
  }) {
    return plan.map(_generateForPlan).toList();
  }

  Puzzle _generateForPlan(LessonPuzzlePlan plan) {
    return switch (plan.kind) {
      LessonPuzzleKind.sequence =>
        _sequenceGenerator.generate(difficulty: plan.difficulty),
      LessonPuzzleKind.logic =>
        _logicGenerator.generate(difficulty: plan.difficulty),
      LessonPuzzleKind.pattern =>
        _patternGenerator.generate(difficulty: plan.difficulty),
    };
  }
}
