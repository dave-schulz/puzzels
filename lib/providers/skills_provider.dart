import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/puzzle/models/puzzle.dart';
import '../features/skill/models/skill_category.dart';
import '../features/skill/models/user_skills.dart';
import '../features/skill/skill_calculator.dart';
import 'progress_persistence.dart';

class SkillsNotifier extends Notifier<UserSkills> {
  @override
  UserSkills build() => UserSkills.defaults;

  void restore(UserSkills skills) {
    state = skills;
  }

  void recordAttempt(Puzzle puzzle, {required bool isCorrect}) {
    final category = skillCategoryFor(puzzle.type);
    final updated = SkillCalculator.adjust(
      state.forCategory(category),
      isCorrect: isCorrect,
    );

    state = state.withCategory(category, updated);
    Future.microtask(() => persistSkillsProgress(ref, state));
  }
}

final skillsProvider =
    NotifierProvider<SkillsNotifier, UserSkills>(SkillsNotifier.new);
