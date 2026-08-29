import 'skill_category.dart';

class UserSkills {
  const UserSkills({
    required this.sequence,
    required this.logic,
    required this.pattern,
  });

  final int sequence;
  final int logic;
  final int pattern;

  static const defaults = UserSkills(
    sequence: UserSkills.defaultSkill,
    logic: UserSkills.defaultSkill,
    pattern: UserSkills.defaultSkill,
  );

  static const defaultSkill = 50;

  int forCategory(SkillCategory category) {
    return switch (category) {
      SkillCategory.sequence => sequence,
      SkillCategory.logic => logic,
      SkillCategory.pattern => pattern,
    };
  }

  UserSkills withCategory(SkillCategory category, int value) {
    return switch (category) {
      SkillCategory.sequence => copyWith(sequence: value),
      SkillCategory.logic => copyWith(logic: value),
      SkillCategory.pattern => copyWith(pattern: value),
    };
  }

  UserSkills copyWith({
    int? sequence,
    int? logic,
    int? pattern,
  }) {
    return UserSkills(
      sequence: sequence ?? this.sequence,
      logic: logic ?? this.logic,
      pattern: pattern ?? this.pattern,
    );
  }
}
