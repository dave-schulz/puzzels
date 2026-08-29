import 'package:drift/drift.dart';

class Users extends Table {
  TextColumn get id => text()();

  TextColumn get displayName => text()();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class UserProgress extends Table {
  TextColumn get userId => text().references(Users, #id)();

  IntColumn get totalXp => integer().withDefault(const Constant(0))();

  IntColumn get streak => integer().withDefault(const Constant(0))();

  IntColumn get sequenceSkill => integer().withDefault(const Constant(50))();

  IntColumn get logicSkill => integer().withDefault(const Constant(50))();

  IntColumn get patternSkill => integer().withDefault(const Constant(50))();

  DateTimeColumn get lastPlayDate => dateTime().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {userId};
}

class Attempts extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get userId => text().references(Users, #id)();

  TextColumn get puzzleId => text()();

  TextColumn get puzzleType => text()();

  TextColumn get difficulty => text()();

  BoolColumn get isCorrect => boolean()();

  IntColumn get xpEarned => integer().withDefault(const Constant(0))();

  DateTimeColumn get attemptedAt => dateTime()();
}

class LessonResults extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get userId => text().references(Users, #id)();

  IntColumn get correctCount => integer()();

  IntColumn get totalCount => integer()();

  IntColumn get xpEarned => integer()();

  DateTimeColumn get completedAt => dateTime()();
}
