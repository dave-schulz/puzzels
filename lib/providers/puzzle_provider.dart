import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/lesson/generators/lesson_generator.dart';
import '../features/puzzle/generators/logic_puzzle_generator.dart';
import '../features/puzzle/generators/pattern_generator.dart';
import '../features/puzzle/generators/sequence_generator.dart';

final sequenceGeneratorProvider = Provider<SequenceGenerator>(
  (ref) => SequenceGenerator(),
);

final logicPuzzleGeneratorProvider = Provider<LogicPuzzleGenerator>(
  (ref) => LogicPuzzleGenerator(),
);

final patternGeneratorProvider = Provider<PatternGenerator>(
  (ref) => PatternGenerator(),
);

final lessonGeneratorProvider = Provider<LessonGenerator>((ref) {
  return LessonGenerator(
    sequenceGenerator: ref.watch(sequenceGeneratorProvider),
    logicGenerator: ref.watch(logicPuzzleGeneratorProvider),
    patternGenerator: ref.watch(patternGeneratorProvider),
  );
});