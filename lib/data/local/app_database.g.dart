// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, displayName, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String displayName;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.displayName,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['display_name'] = Variable<String>(displayName);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      displayName: Value(displayName),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      displayName: serializer.fromJson<String>(json['displayName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'displayName': serializer.toJson<String>(displayName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({String? id, String? displayName, DateTime? createdAt}) => User(
    id: id ?? this.id,
    displayName: displayName ?? this.displayName,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, displayName, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.displayName == this.displayName &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> displayName;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.displayName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String displayName,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       displayName = Value(displayName),
       createdAt = Value(createdAt);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? displayName,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (displayName != null) 'display_name': displayName,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? displayName,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('displayName: $displayName, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProgressTable extends UserProgress
    with TableInfo<$UserProgressTable, UserProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _totalXpMeta = const VerificationMeta(
    'totalXp',
  );
  @override
  late final GeneratedColumn<int> totalXp = GeneratedColumn<int>(
    'total_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _streakMeta = const VerificationMeta('streak');
  @override
  late final GeneratedColumn<int> streak = GeneratedColumn<int>(
    'streak',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sequenceSkillMeta = const VerificationMeta(
    'sequenceSkill',
  );
  @override
  late final GeneratedColumn<int> sequenceSkill = GeneratedColumn<int>(
    'sequence_skill',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _logicSkillMeta = const VerificationMeta(
    'logicSkill',
  );
  @override
  late final GeneratedColumn<int> logicSkill = GeneratedColumn<int>(
    'logic_skill',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _patternSkillMeta = const VerificationMeta(
    'patternSkill',
  );
  @override
  late final GeneratedColumn<int> patternSkill = GeneratedColumn<int>(
    'pattern_skill',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(50),
  );
  static const VerificationMeta _lastPlayDateMeta = const VerificationMeta(
    'lastPlayDate',
  );
  @override
  late final GeneratedColumn<DateTime> lastPlayDate = GeneratedColumn<DateTime>(
    'last_play_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    totalXp,
    streak,
    sequenceSkill,
    logicSkill,
    patternSkill,
    lastPlayDate,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('total_xp')) {
      context.handle(
        _totalXpMeta,
        totalXp.isAcceptableOrUnknown(data['total_xp']!, _totalXpMeta),
      );
    }
    if (data.containsKey('streak')) {
      context.handle(
        _streakMeta,
        streak.isAcceptableOrUnknown(data['streak']!, _streakMeta),
      );
    }
    if (data.containsKey('sequence_skill')) {
      context.handle(
        _sequenceSkillMeta,
        sequenceSkill.isAcceptableOrUnknown(
          data['sequence_skill']!,
          _sequenceSkillMeta,
        ),
      );
    }
    if (data.containsKey('logic_skill')) {
      context.handle(
        _logicSkillMeta,
        logicSkill.isAcceptableOrUnknown(data['logic_skill']!, _logicSkillMeta),
      );
    }
    if (data.containsKey('pattern_skill')) {
      context.handle(
        _patternSkillMeta,
        patternSkill.isAcceptableOrUnknown(
          data['pattern_skill']!,
          _patternSkillMeta,
        ),
      );
    }
    if (data.containsKey('last_play_date')) {
      context.handle(
        _lastPlayDateMeta,
        lastPlayDate.isAcceptableOrUnknown(
          data['last_play_date']!,
          _lastPlayDateMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProgressData(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      totalXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_xp'],
      )!,
      streak: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak'],
      )!,
      sequenceSkill: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence_skill'],
      )!,
      logicSkill: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}logic_skill'],
      )!,
      patternSkill: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pattern_skill'],
      )!,
      lastPlayDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_play_date'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProgressTable createAlias(String alias) {
    return $UserProgressTable(attachedDatabase, alias);
  }
}

class UserProgressData extends DataClass
    implements Insertable<UserProgressData> {
  final String userId;
  final int totalXp;
  final int streak;
  final int sequenceSkill;
  final int logicSkill;
  final int patternSkill;
  final DateTime? lastPlayDate;
  final DateTime updatedAt;
  const UserProgressData({
    required this.userId,
    required this.totalXp,
    required this.streak,
    required this.sequenceSkill,
    required this.logicSkill,
    required this.patternSkill,
    this.lastPlayDate,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['total_xp'] = Variable<int>(totalXp);
    map['streak'] = Variable<int>(streak);
    map['sequence_skill'] = Variable<int>(sequenceSkill);
    map['logic_skill'] = Variable<int>(logicSkill);
    map['pattern_skill'] = Variable<int>(patternSkill);
    if (!nullToAbsent || lastPlayDate != null) {
      map['last_play_date'] = Variable<DateTime>(lastPlayDate);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProgressCompanion toCompanion(bool nullToAbsent) {
    return UserProgressCompanion(
      userId: Value(userId),
      totalXp: Value(totalXp),
      streak: Value(streak),
      sequenceSkill: Value(sequenceSkill),
      logicSkill: Value(logicSkill),
      patternSkill: Value(patternSkill),
      lastPlayDate: lastPlayDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPlayDate),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProgressData(
      userId: serializer.fromJson<String>(json['userId']),
      totalXp: serializer.fromJson<int>(json['totalXp']),
      streak: serializer.fromJson<int>(json['streak']),
      sequenceSkill: serializer.fromJson<int>(json['sequenceSkill']),
      logicSkill: serializer.fromJson<int>(json['logicSkill']),
      patternSkill: serializer.fromJson<int>(json['patternSkill']),
      lastPlayDate: serializer.fromJson<DateTime?>(json['lastPlayDate']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'totalXp': serializer.toJson<int>(totalXp),
      'streak': serializer.toJson<int>(streak),
      'sequenceSkill': serializer.toJson<int>(sequenceSkill),
      'logicSkill': serializer.toJson<int>(logicSkill),
      'patternSkill': serializer.toJson<int>(patternSkill),
      'lastPlayDate': serializer.toJson<DateTime?>(lastPlayDate),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProgressData copyWith({
    String? userId,
    int? totalXp,
    int? streak,
    int? sequenceSkill,
    int? logicSkill,
    int? patternSkill,
    Value<DateTime?> lastPlayDate = const Value.absent(),
    DateTime? updatedAt,
  }) => UserProgressData(
    userId: userId ?? this.userId,
    totalXp: totalXp ?? this.totalXp,
    streak: streak ?? this.streak,
    sequenceSkill: sequenceSkill ?? this.sequenceSkill,
    logicSkill: logicSkill ?? this.logicSkill,
    patternSkill: patternSkill ?? this.patternSkill,
    lastPlayDate: lastPlayDate.present ? lastPlayDate.value : this.lastPlayDate,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProgressData copyWithCompanion(UserProgressCompanion data) {
    return UserProgressData(
      userId: data.userId.present ? data.userId.value : this.userId,
      totalXp: data.totalXp.present ? data.totalXp.value : this.totalXp,
      streak: data.streak.present ? data.streak.value : this.streak,
      sequenceSkill: data.sequenceSkill.present
          ? data.sequenceSkill.value
          : this.sequenceSkill,
      logicSkill: data.logicSkill.present
          ? data.logicSkill.value
          : this.logicSkill,
      patternSkill: data.patternSkill.present
          ? data.patternSkill.value
          : this.patternSkill,
      lastPlayDate: data.lastPlayDate.present
          ? data.lastPlayDate.value
          : this.lastPlayDate,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressData(')
          ..write('userId: $userId, ')
          ..write('totalXp: $totalXp, ')
          ..write('streak: $streak, ')
          ..write('sequenceSkill: $sequenceSkill, ')
          ..write('logicSkill: $logicSkill, ')
          ..write('patternSkill: $patternSkill, ')
          ..write('lastPlayDate: $lastPlayDate, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    totalXp,
    streak,
    sequenceSkill,
    logicSkill,
    patternSkill,
    lastPlayDate,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProgressData &&
          other.userId == this.userId &&
          other.totalXp == this.totalXp &&
          other.streak == this.streak &&
          other.sequenceSkill == this.sequenceSkill &&
          other.logicSkill == this.logicSkill &&
          other.patternSkill == this.patternSkill &&
          other.lastPlayDate == this.lastPlayDate &&
          other.updatedAt == this.updatedAt);
}

class UserProgressCompanion extends UpdateCompanion<UserProgressData> {
  final Value<String> userId;
  final Value<int> totalXp;
  final Value<int> streak;
  final Value<int> sequenceSkill;
  final Value<int> logicSkill;
  final Value<int> patternSkill;
  final Value<DateTime?> lastPlayDate;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserProgressCompanion({
    this.userId = const Value.absent(),
    this.totalXp = const Value.absent(),
    this.streak = const Value.absent(),
    this.sequenceSkill = const Value.absent(),
    this.logicSkill = const Value.absent(),
    this.patternSkill = const Value.absent(),
    this.lastPlayDate = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProgressCompanion.insert({
    required String userId,
    this.totalXp = const Value.absent(),
    this.streak = const Value.absent(),
    this.sequenceSkill = const Value.absent(),
    this.logicSkill = const Value.absent(),
    this.patternSkill = const Value.absent(),
    this.lastPlayDate = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       updatedAt = Value(updatedAt);
  static Insertable<UserProgressData> custom({
    Expression<String>? userId,
    Expression<int>? totalXp,
    Expression<int>? streak,
    Expression<int>? sequenceSkill,
    Expression<int>? logicSkill,
    Expression<int>? patternSkill,
    Expression<DateTime>? lastPlayDate,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (totalXp != null) 'total_xp': totalXp,
      if (streak != null) 'streak': streak,
      if (sequenceSkill != null) 'sequence_skill': sequenceSkill,
      if (logicSkill != null) 'logic_skill': logicSkill,
      if (patternSkill != null) 'pattern_skill': patternSkill,
      if (lastPlayDate != null) 'last_play_date': lastPlayDate,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProgressCompanion copyWith({
    Value<String>? userId,
    Value<int>? totalXp,
    Value<int>? streak,
    Value<int>? sequenceSkill,
    Value<int>? logicSkill,
    Value<int>? patternSkill,
    Value<DateTime?>? lastPlayDate,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserProgressCompanion(
      userId: userId ?? this.userId,
      totalXp: totalXp ?? this.totalXp,
      streak: streak ?? this.streak,
      sequenceSkill: sequenceSkill ?? this.sequenceSkill,
      logicSkill: logicSkill ?? this.logicSkill,
      patternSkill: patternSkill ?? this.patternSkill,
      lastPlayDate: lastPlayDate ?? this.lastPlayDate,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (totalXp.present) {
      map['total_xp'] = Variable<int>(totalXp.value);
    }
    if (streak.present) {
      map['streak'] = Variable<int>(streak.value);
    }
    if (sequenceSkill.present) {
      map['sequence_skill'] = Variable<int>(sequenceSkill.value);
    }
    if (logicSkill.present) {
      map['logic_skill'] = Variable<int>(logicSkill.value);
    }
    if (patternSkill.present) {
      map['pattern_skill'] = Variable<int>(patternSkill.value);
    }
    if (lastPlayDate.present) {
      map['last_play_date'] = Variable<DateTime>(lastPlayDate.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProgressCompanion(')
          ..write('userId: $userId, ')
          ..write('totalXp: $totalXp, ')
          ..write('streak: $streak, ')
          ..write('sequenceSkill: $sequenceSkill, ')
          ..write('logicSkill: $logicSkill, ')
          ..write('patternSkill: $patternSkill, ')
          ..write('lastPlayDate: $lastPlayDate, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttemptsTable extends Attempts with TableInfo<$AttemptsTable, Attempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _puzzleIdMeta = const VerificationMeta(
    'puzzleId',
  );
  @override
  late final GeneratedColumn<String> puzzleId = GeneratedColumn<String>(
    'puzzle_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _puzzleTypeMeta = const VerificationMeta(
    'puzzleType',
  );
  @override
  late final GeneratedColumn<String> puzzleType = GeneratedColumn<String>(
    'puzzle_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCorrectMeta = const VerificationMeta(
    'isCorrect',
  );
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
    'is_correct',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_correct" IN (0, 1))',
    ),
  );
  static const VerificationMeta _xpEarnedMeta = const VerificationMeta(
    'xpEarned',
  );
  @override
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
    'xp_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _attemptedAtMeta = const VerificationMeta(
    'attemptedAt',
  );
  @override
  late final GeneratedColumn<DateTime> attemptedAt = GeneratedColumn<DateTime>(
    'attempted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    puzzleId,
    puzzleType,
    difficulty,
    isCorrect,
    xpEarned,
    attemptedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Attempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('puzzle_id')) {
      context.handle(
        _puzzleIdMeta,
        puzzleId.isAcceptableOrUnknown(data['puzzle_id']!, _puzzleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_puzzleIdMeta);
    }
    if (data.containsKey('puzzle_type')) {
      context.handle(
        _puzzleTypeMeta,
        puzzleType.isAcceptableOrUnknown(data['puzzle_type']!, _puzzleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_puzzleTypeMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('is_correct')) {
      context.handle(
        _isCorrectMeta,
        isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta),
      );
    } else if (isInserting) {
      context.missing(_isCorrectMeta);
    }
    if (data.containsKey('xp_earned')) {
      context.handle(
        _xpEarnedMeta,
        xpEarned.isAcceptableOrUnknown(data['xp_earned']!, _xpEarnedMeta),
      );
    }
    if (data.containsKey('attempted_at')) {
      context.handle(
        _attemptedAtMeta,
        attemptedAt.isAcceptableOrUnknown(
          data['attempted_at']!,
          _attemptedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attemptedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Attempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Attempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      puzzleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzle_id'],
      )!,
      puzzleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}puzzle_type'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      isCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_correct'],
      )!,
      xpEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_earned'],
      )!,
      attemptedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}attempted_at'],
      )!,
    );
  }

  @override
  $AttemptsTable createAlias(String alias) {
    return $AttemptsTable(attachedDatabase, alias);
  }
}

class Attempt extends DataClass implements Insertable<Attempt> {
  final int id;
  final String userId;
  final String puzzleId;
  final String puzzleType;
  final String difficulty;
  final bool isCorrect;
  final int xpEarned;
  final DateTime attemptedAt;
  const Attempt({
    required this.id,
    required this.userId,
    required this.puzzleId,
    required this.puzzleType,
    required this.difficulty,
    required this.isCorrect,
    required this.xpEarned,
    required this.attemptedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['puzzle_id'] = Variable<String>(puzzleId);
    map['puzzle_type'] = Variable<String>(puzzleType);
    map['difficulty'] = Variable<String>(difficulty);
    map['is_correct'] = Variable<bool>(isCorrect);
    map['xp_earned'] = Variable<int>(xpEarned);
    map['attempted_at'] = Variable<DateTime>(attemptedAt);
    return map;
  }

  AttemptsCompanion toCompanion(bool nullToAbsent) {
    return AttemptsCompanion(
      id: Value(id),
      userId: Value(userId),
      puzzleId: Value(puzzleId),
      puzzleType: Value(puzzleType),
      difficulty: Value(difficulty),
      isCorrect: Value(isCorrect),
      xpEarned: Value(xpEarned),
      attemptedAt: Value(attemptedAt),
    );
  }

  factory Attempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Attempt(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      puzzleId: serializer.fromJson<String>(json['puzzleId']),
      puzzleType: serializer.fromJson<String>(json['puzzleType']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
      xpEarned: serializer.fromJson<int>(json['xpEarned']),
      attemptedAt: serializer.fromJson<DateTime>(json['attemptedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'puzzleId': serializer.toJson<String>(puzzleId),
      'puzzleType': serializer.toJson<String>(puzzleType),
      'difficulty': serializer.toJson<String>(difficulty),
      'isCorrect': serializer.toJson<bool>(isCorrect),
      'xpEarned': serializer.toJson<int>(xpEarned),
      'attemptedAt': serializer.toJson<DateTime>(attemptedAt),
    };
  }

  Attempt copyWith({
    int? id,
    String? userId,
    String? puzzleId,
    String? puzzleType,
    String? difficulty,
    bool? isCorrect,
    int? xpEarned,
    DateTime? attemptedAt,
  }) => Attempt(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    puzzleId: puzzleId ?? this.puzzleId,
    puzzleType: puzzleType ?? this.puzzleType,
    difficulty: difficulty ?? this.difficulty,
    isCorrect: isCorrect ?? this.isCorrect,
    xpEarned: xpEarned ?? this.xpEarned,
    attemptedAt: attemptedAt ?? this.attemptedAt,
  );
  Attempt copyWithCompanion(AttemptsCompanion data) {
    return Attempt(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      puzzleId: data.puzzleId.present ? data.puzzleId.value : this.puzzleId,
      puzzleType: data.puzzleType.present
          ? data.puzzleType.value
          : this.puzzleType,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
      attemptedAt: data.attemptedAt.present
          ? data.attemptedAt.value
          : this.attemptedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Attempt(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('puzzleType: $puzzleType, ')
          ..write('difficulty: $difficulty, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('attemptedAt: $attemptedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    puzzleId,
    puzzleType,
    difficulty,
    isCorrect,
    xpEarned,
    attemptedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Attempt &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.puzzleId == this.puzzleId &&
          other.puzzleType == this.puzzleType &&
          other.difficulty == this.difficulty &&
          other.isCorrect == this.isCorrect &&
          other.xpEarned == this.xpEarned &&
          other.attemptedAt == this.attemptedAt);
}

class AttemptsCompanion extends UpdateCompanion<Attempt> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> puzzleId;
  final Value<String> puzzleType;
  final Value<String> difficulty;
  final Value<bool> isCorrect;
  final Value<int> xpEarned;
  final Value<DateTime> attemptedAt;
  const AttemptsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.puzzleId = const Value.absent(),
    this.puzzleType = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.attemptedAt = const Value.absent(),
  });
  AttemptsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String puzzleId,
    required String puzzleType,
    required String difficulty,
    required bool isCorrect,
    this.xpEarned = const Value.absent(),
    required DateTime attemptedAt,
  }) : userId = Value(userId),
       puzzleId = Value(puzzleId),
       puzzleType = Value(puzzleType),
       difficulty = Value(difficulty),
       isCorrect = Value(isCorrect),
       attemptedAt = Value(attemptedAt);
  static Insertable<Attempt> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? puzzleId,
    Expression<String>? puzzleType,
    Expression<String>? difficulty,
    Expression<bool>? isCorrect,
    Expression<int>? xpEarned,
    Expression<DateTime>? attemptedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (puzzleId != null) 'puzzle_id': puzzleId,
      if (puzzleType != null) 'puzzle_type': puzzleType,
      if (difficulty != null) 'difficulty': difficulty,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (attemptedAt != null) 'attempted_at': attemptedAt,
    });
  }

  AttemptsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? puzzleId,
    Value<String>? puzzleType,
    Value<String>? difficulty,
    Value<bool>? isCorrect,
    Value<int>? xpEarned,
    Value<DateTime>? attemptedAt,
  }) {
    return AttemptsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      puzzleId: puzzleId ?? this.puzzleId,
      puzzleType: puzzleType ?? this.puzzleType,
      difficulty: difficulty ?? this.difficulty,
      isCorrect: isCorrect ?? this.isCorrect,
      xpEarned: xpEarned ?? this.xpEarned,
      attemptedAt: attemptedAt ?? this.attemptedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (puzzleId.present) {
      map['puzzle_id'] = Variable<String>(puzzleId.value);
    }
    if (puzzleType.present) {
      map['puzzle_type'] = Variable<String>(puzzleType.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (attemptedAt.present) {
      map['attempted_at'] = Variable<DateTime>(attemptedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttemptsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('puzzleId: $puzzleId, ')
          ..write('puzzleType: $puzzleType, ')
          ..write('difficulty: $difficulty, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('attemptedAt: $attemptedAt')
          ..write(')'))
        .toString();
  }
}

class $LessonResultsTable extends LessonResults
    with TableInfo<$LessonResultsTable, LessonResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LessonResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalCountMeta = const VerificationMeta(
    'totalCount',
  );
  @override
  late final GeneratedColumn<int> totalCount = GeneratedColumn<int>(
    'total_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpEarnedMeta = const VerificationMeta(
    'xpEarned',
  );
  @override
  late final GeneratedColumn<int> xpEarned = GeneratedColumn<int>(
    'xp_earned',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    correctCount,
    totalCount,
    xpEarned,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lesson_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<LessonResult> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctCountMeta);
    }
    if (data.containsKey('total_count')) {
      context.handle(
        _totalCountMeta,
        totalCount.isAcceptableOrUnknown(data['total_count']!, _totalCountMeta),
      );
    } else if (isInserting) {
      context.missing(_totalCountMeta);
    }
    if (data.containsKey('xp_earned')) {
      context.handle(
        _xpEarnedMeta,
        xpEarned.isAcceptableOrUnknown(data['xp_earned']!, _xpEarnedMeta),
      );
    } else if (isInserting) {
      context.missing(_xpEarnedMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LessonResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LessonResult(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      )!,
      totalCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_count'],
      )!,
      xpEarned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp_earned'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
    );
  }

  @override
  $LessonResultsTable createAlias(String alias) {
    return $LessonResultsTable(attachedDatabase, alias);
  }
}

class LessonResult extends DataClass implements Insertable<LessonResult> {
  final int id;
  final String userId;
  final int correctCount;
  final int totalCount;
  final int xpEarned;
  final DateTime completedAt;
  const LessonResult({
    required this.id,
    required this.userId,
    required this.correctCount,
    required this.totalCount,
    required this.xpEarned,
    required this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['correct_count'] = Variable<int>(correctCount);
    map['total_count'] = Variable<int>(totalCount);
    map['xp_earned'] = Variable<int>(xpEarned);
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  LessonResultsCompanion toCompanion(bool nullToAbsent) {
    return LessonResultsCompanion(
      id: Value(id),
      userId: Value(userId),
      correctCount: Value(correctCount),
      totalCount: Value(totalCount),
      xpEarned: Value(xpEarned),
      completedAt: Value(completedAt),
    );
  }

  factory LessonResult.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LessonResult(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      totalCount: serializer.fromJson<int>(json['totalCount']),
      xpEarned: serializer.fromJson<int>(json['xpEarned']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'correctCount': serializer.toJson<int>(correctCount),
      'totalCount': serializer.toJson<int>(totalCount),
      'xpEarned': serializer.toJson<int>(xpEarned),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  LessonResult copyWith({
    int? id,
    String? userId,
    int? correctCount,
    int? totalCount,
    int? xpEarned,
    DateTime? completedAt,
  }) => LessonResult(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    correctCount: correctCount ?? this.correctCount,
    totalCount: totalCount ?? this.totalCount,
    xpEarned: xpEarned ?? this.xpEarned,
    completedAt: completedAt ?? this.completedAt,
  );
  LessonResult copyWithCompanion(LessonResultsCompanion data) {
    return LessonResult(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      totalCount: data.totalCount.present
          ? data.totalCount.value
          : this.totalCount,
      xpEarned: data.xpEarned.present ? data.xpEarned.value : this.xpEarned,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LessonResult(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('correctCount: $correctCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, correctCount, totalCount, xpEarned, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LessonResult &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.correctCount == this.correctCount &&
          other.totalCount == this.totalCount &&
          other.xpEarned == this.xpEarned &&
          other.completedAt == this.completedAt);
}

class LessonResultsCompanion extends UpdateCompanion<LessonResult> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> correctCount;
  final Value<int> totalCount;
  final Value<int> xpEarned;
  final Value<DateTime> completedAt;
  const LessonResultsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.totalCount = const Value.absent(),
    this.xpEarned = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  LessonResultsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int correctCount,
    required int totalCount,
    required int xpEarned,
    required DateTime completedAt,
  }) : userId = Value(userId),
       correctCount = Value(correctCount),
       totalCount = Value(totalCount),
       xpEarned = Value(xpEarned),
       completedAt = Value(completedAt);
  static Insertable<LessonResult> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? correctCount,
    Expression<int>? totalCount,
    Expression<int>? xpEarned,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (correctCount != null) 'correct_count': correctCount,
      if (totalCount != null) 'total_count': totalCount,
      if (xpEarned != null) 'xp_earned': xpEarned,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  LessonResultsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? correctCount,
    Value<int>? totalCount,
    Value<int>? xpEarned,
    Value<DateTime>? completedAt,
  }) {
    return LessonResultsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      correctCount: correctCount ?? this.correctCount,
      totalCount: totalCount ?? this.totalCount,
      xpEarned: xpEarned ?? this.xpEarned,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (totalCount.present) {
      map['total_count'] = Variable<int>(totalCount.value);
    }
    if (xpEarned.present) {
      map['xp_earned'] = Variable<int>(xpEarned.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LessonResultsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('correctCount: $correctCount, ')
          ..write('totalCount: $totalCount, ')
          ..write('xpEarned: $xpEarned, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $UserProgressTable userProgress = $UserProgressTable(this);
  late final $AttemptsTable attempts = $AttemptsTable(this);
  late final $LessonResultsTable lessonResults = $LessonResultsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    userProgress,
    attempts,
    lessonResults,
  ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String displayName,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> displayName,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$UserProgressTable, List<UserProgressData>>
  _userProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userProgress,
    aliasName: 'users__id__user_progress__user_id',
  );

  $$UserProgressTableProcessedTableManager get userProgressRefs {
    final manager = $$UserProgressTableTableManager(
      $_db,
      $_db.userProgress,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userProgressRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AttemptsTable, List<Attempt>> _attemptsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.attempts,
    aliasName: 'users__id__attempts__user_id',
  );

  $$AttemptsTableProcessedTableManager get attemptsRefs {
    final manager = $$AttemptsTableTableManager(
      $_db,
      $_db.attempts,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_attemptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LessonResultsTable, List<LessonResult>>
  _lessonResultsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lessonResults,
    aliasName: 'users__id__lesson_results__user_id',
  );

  $$LessonResultsTableProcessedTableManager get lessonResultsRefs {
    final manager = $$LessonResultsTableTableManager(
      $_db,
      $_db.lessonResults,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_lessonResultsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userProgressRefs(
    Expression<bool> Function($$UserProgressTableFilterComposer f) f,
  ) {
    final $$UserProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userProgress,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProgressTableFilterComposer(
            $db: $db,
            $table: $db.userProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> attemptsRefs(
    Expression<bool> Function($$AttemptsTableFilterComposer f) f,
  ) {
    final $$AttemptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attempts,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttemptsTableFilterComposer(
            $db: $db,
            $table: $db.attempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> lessonResultsRefs(
    Expression<bool> Function($$LessonResultsTableFilterComposer f) f,
  ) {
    final $$LessonResultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessonResults,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonResultsTableFilterComposer(
            $db: $db,
            $table: $db.lessonResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> userProgressRefs<T extends Object>(
    Expression<T> Function($$UserProgressTableAnnotationComposer a) f,
  ) {
    final $$UserProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userProgress,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.userProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> attemptsRefs<T extends Object>(
    Expression<T> Function($$AttemptsTableAnnotationComposer a) f,
  ) {
    final $$AttemptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attempts,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttemptsTableAnnotationComposer(
            $db: $db,
            $table: $db.attempts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> lessonResultsRefs<T extends Object>(
    Expression<T> Function($$LessonResultsTableAnnotationComposer a) f,
  ) {
    final $$LessonResultsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lessonResults,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LessonResultsTableAnnotationComposer(
            $db: $db,
            $table: $db.lessonResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool userProgressRefs,
            bool attemptsRefs,
            bool lessonResultsRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                displayName: displayName,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String displayName,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                displayName: displayName,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UsersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userProgressRefs = false,
                attemptsRefs = false,
                lessonResultsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (userProgressRefs) db.userProgress,
                    if (attemptsRefs) db.attempts,
                    if (lessonResultsRefs) db.lessonResults,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (userProgressRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          UserProgressData
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._userProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).userProgressRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (attemptsRefs)
                        await $_getPrefetchedData<User, $UsersTable, Attempt>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._attemptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).attemptsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (lessonResultsRefs)
                        await $_getPrefetchedData<
                          User,
                          $UsersTable,
                          LessonResult
                        >(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences
                              ._lessonResultsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsersTableReferences(
                                db,
                                table,
                                p0,
                              ).lessonResultsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool userProgressRefs,
        bool attemptsRefs,
        bool lessonResultsRefs,
      })
    >;
typedef $$UserProgressTableCreateCompanionBuilder =
    UserProgressCompanion Function({
      required String userId,
      Value<int> totalXp,
      Value<int> streak,
      Value<int> sequenceSkill,
      Value<int> logicSkill,
      Value<int> patternSkill,
      Value<DateTime?> lastPlayDate,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$UserProgressTableUpdateCompanionBuilder =
    UserProgressCompanion Function({
      Value<String> userId,
      Value<int> totalXp,
      Value<int> streak,
      Value<int> sequenceSkill,
      Value<int> logicSkill,
      Value<int> patternSkill,
      Value<DateTime?> lastPlayDate,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$UserProgressTableReferences
    extends
        BaseReferences<_$AppDatabase, $UserProgressTable, UserProgressData> {
  $$UserProgressTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('user_progress__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserProgressTableFilterComposer
    extends Composer<_$AppDatabase, $UserProgressTable> {
  $$UserProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streak => $composableBuilder(
    column: $table.streak,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequenceSkill => $composableBuilder(
    column: $table.sequenceSkill,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get logicSkill => $composableBuilder(
    column: $table.logicSkill,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get patternSkill => $composableBuilder(
    column: $table.patternSkill,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastPlayDate => $composableBuilder(
    column: $table.lastPlayDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProgressTable> {
  $$UserProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get totalXp => $composableBuilder(
    column: $table.totalXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streak => $composableBuilder(
    column: $table.streak,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequenceSkill => $composableBuilder(
    column: $table.sequenceSkill,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get logicSkill => $composableBuilder(
    column: $table.logicSkill,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get patternSkill => $composableBuilder(
    column: $table.patternSkill,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastPlayDate => $composableBuilder(
    column: $table.lastPlayDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProgressTable> {
  $$UserProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get totalXp =>
      $composableBuilder(column: $table.totalXp, builder: (column) => column);

  GeneratedColumn<int> get streak =>
      $composableBuilder(column: $table.streak, builder: (column) => column);

  GeneratedColumn<int> get sequenceSkill => $composableBuilder(
    column: $table.sequenceSkill,
    builder: (column) => column,
  );

  GeneratedColumn<int> get logicSkill => $composableBuilder(
    column: $table.logicSkill,
    builder: (column) => column,
  );

  GeneratedColumn<int> get patternSkill => $composableBuilder(
    column: $table.patternSkill,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastPlayDate => $composableBuilder(
    column: $table.lastPlayDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProgressTable,
          UserProgressData,
          $$UserProgressTableFilterComposer,
          $$UserProgressTableOrderingComposer,
          $$UserProgressTableAnnotationComposer,
          $$UserProgressTableCreateCompanionBuilder,
          $$UserProgressTableUpdateCompanionBuilder,
          (UserProgressData, $$UserProgressTableReferences),
          UserProgressData,
          PrefetchHooks Function({bool userId})
        > {
  $$UserProgressTableTableManager(_$AppDatabase db, $UserProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<int> totalXp = const Value.absent(),
                Value<int> streak = const Value.absent(),
                Value<int> sequenceSkill = const Value.absent(),
                Value<int> logicSkill = const Value.absent(),
                Value<int> patternSkill = const Value.absent(),
                Value<DateTime?> lastPlayDate = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProgressCompanion(
                userId: userId,
                totalXp: totalXp,
                streak: streak,
                sequenceSkill: sequenceSkill,
                logicSkill: logicSkill,
                patternSkill: patternSkill,
                lastPlayDate: lastPlayDate,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                Value<int> totalXp = const Value.absent(),
                Value<int> streak = const Value.absent(),
                Value<int> sequenceSkill = const Value.absent(),
                Value<int> logicSkill = const Value.absent(),
                Value<int> patternSkill = const Value.absent(),
                Value<DateTime?> lastPlayDate = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => UserProgressCompanion.insert(
                userId: userId,
                totalXp: totalXp,
                streak: streak,
                sequenceSkill: sequenceSkill,
                logicSkill: logicSkill,
                patternSkill: patternSkill,
                lastPlayDate: lastPlayDate,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$UserProgressTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$UserProgressTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProgressTable,
      UserProgressData,
      $$UserProgressTableFilterComposer,
      $$UserProgressTableOrderingComposer,
      $$UserProgressTableAnnotationComposer,
      $$UserProgressTableCreateCompanionBuilder,
      $$UserProgressTableUpdateCompanionBuilder,
      (UserProgressData, $$UserProgressTableReferences),
      UserProgressData,
      PrefetchHooks Function({bool userId})
    >;
typedef $$AttemptsTableCreateCompanionBuilder = AttemptsCompanion Function({
  Value<int> id,
  required String userId,
  required String puzzleId,
  required String puzzleType,
  required String difficulty,
  required bool isCorrect,
  Value<int> xpEarned,
  required DateTime attemptedAt,
});
typedef $$AttemptsTableUpdateCompanionBuilder = AttemptsCompanion Function({
  Value<int> id,
  Value<String> userId,
  Value<String> puzzleId,
  Value<String> puzzleType,
  Value<String> difficulty,
  Value<bool> isCorrect,
  Value<int> xpEarned,
  Value<DateTime> attemptedAt,
});

final class $$AttemptsTableReferences
    extends BaseReferences<_$AppDatabase, $AttemptsTable, Attempt> {
  $$AttemptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('attempts__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $AttemptsTable> {
  $$AttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get puzzleType => $composableBuilder(
    column: $table.puzzleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttemptsTable> {
  $$AttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puzzleId => $composableBuilder(
    column: $table.puzzleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get puzzleType => $composableBuilder(
    column: $table.puzzleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
    column: $table.isCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttemptsTable> {
  $$AttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get puzzleId =>
      $composableBuilder(column: $table.puzzleId, builder: (column) => column);

  GeneratedColumn<String> get puzzleType => $composableBuilder(
    column: $table.puzzleType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  GeneratedColumn<int> get xpEarned =>
      $composableBuilder(column: $table.xpEarned, builder: (column) => column);

  GeneratedColumn<DateTime> get attemptedAt => $composableBuilder(
    column: $table.attemptedAt,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttemptsTable,
          Attempt,
          $$AttemptsTableFilterComposer,
          $$AttemptsTableOrderingComposer,
          $$AttemptsTableAnnotationComposer,
          $$AttemptsTableCreateCompanionBuilder,
          $$AttemptsTableUpdateCompanionBuilder,
          (Attempt, $$AttemptsTableReferences),
          Attempt,
          PrefetchHooks Function({bool userId})
        > {
  $$AttemptsTableTableManager(_$AppDatabase db, $AttemptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> puzzleId = const Value.absent(),
                Value<String> puzzleType = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<bool> isCorrect = const Value.absent(),
                Value<int> xpEarned = const Value.absent(),
                Value<DateTime> attemptedAt = const Value.absent(),
              }) => AttemptsCompanion(
                id: id,
                userId: userId,
                puzzleId: puzzleId,
                puzzleType: puzzleType,
                difficulty: difficulty,
                isCorrect: isCorrect,
                xpEarned: xpEarned,
                attemptedAt: attemptedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String puzzleId,
                required String puzzleType,
                required String difficulty,
                required bool isCorrect,
                Value<int> xpEarned = const Value.absent(),
                required DateTime attemptedAt,
              }) => AttemptsCompanion.insert(
                id: id,
                userId: userId,
                puzzleId: puzzleId,
                puzzleType: puzzleType,
                difficulty: difficulty,
                isCorrect: isCorrect,
                xpEarned: xpEarned,
                attemptedAt: attemptedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttemptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$AttemptsTableReferences._userIdTable(
                          db,
                        ),
                        referencedColumn: $$AttemptsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttemptsTable,
      Attempt,
      $$AttemptsTableFilterComposer,
      $$AttemptsTableOrderingComposer,
      $$AttemptsTableAnnotationComposer,
      $$AttemptsTableCreateCompanionBuilder,
      $$AttemptsTableUpdateCompanionBuilder,
      (Attempt, $$AttemptsTableReferences),
      Attempt,
      PrefetchHooks Function({bool userId})
    >;
typedef $$LessonResultsTableCreateCompanionBuilder =
    LessonResultsCompanion Function({
      Value<int> id,
      required String userId,
      required int correctCount,
      required int totalCount,
      required int xpEarned,
      required DateTime completedAt,
    });
typedef $$LessonResultsTableUpdateCompanionBuilder =
    LessonResultsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> correctCount,
      Value<int> totalCount,
      Value<int> xpEarned,
      Value<DateTime> completedAt,
    });

final class $$LessonResultsTableReferences
    extends BaseReferences<_$AppDatabase, $LessonResultsTable, LessonResult> {
  $$LessonResultsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('lesson_results__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LessonResultsTableFilterComposer
    extends Composer<_$AppDatabase, $LessonResultsTable> {
  $$LessonResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $LessonResultsTable> {
  $$LessonResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xpEarned => $composableBuilder(
    column: $table.xpEarned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LessonResultsTable> {
  $$LessonResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCount => $composableBuilder(
    column: $table.totalCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xpEarned =>
      $composableBuilder(column: $table.xpEarned, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LessonResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LessonResultsTable,
          LessonResult,
          $$LessonResultsTableFilterComposer,
          $$LessonResultsTableOrderingComposer,
          $$LessonResultsTableAnnotationComposer,
          $$LessonResultsTableCreateCompanionBuilder,
          $$LessonResultsTableUpdateCompanionBuilder,
          (LessonResult, $$LessonResultsTableReferences),
          LessonResult,
          PrefetchHooks Function({bool userId})
        > {
  $$LessonResultsTableTableManager(_$AppDatabase db, $LessonResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LessonResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LessonResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LessonResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> correctCount = const Value.absent(),
                Value<int> totalCount = const Value.absent(),
                Value<int> xpEarned = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
              }) => LessonResultsCompanion(
                id: id,
                userId: userId,
                correctCount: correctCount,
                totalCount: totalCount,
                xpEarned: xpEarned,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int correctCount,
                required int totalCount,
                required int xpEarned,
                required DateTime completedAt,
              }) => LessonResultsCompanion.insert(
                id: id,
                userId: userId,
                correctCount: correctCount,
                totalCount: totalCount,
                xpEarned: xpEarned,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LessonResultsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$LessonResultsTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$LessonResultsTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LessonResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LessonResultsTable,
      LessonResult,
      $$LessonResultsTableFilterComposer,
      $$LessonResultsTableOrderingComposer,
      $$LessonResultsTableAnnotationComposer,
      $$LessonResultsTableCreateCompanionBuilder,
      $$LessonResultsTableUpdateCompanionBuilder,
      (LessonResult, $$LessonResultsTableReferences),
      LessonResult,
      PrefetchHooks Function({bool userId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$UserProgressTableTableManager get userProgress =>
      $$UserProgressTableTableManager(_db, _db.userProgress);
  $$AttemptsTableTableManager get attempts =>
      $$AttemptsTableTableManager(_db, _db.attempts);
  $$LessonResultsTableTableManager get lessonResults =>
      $$LessonResultsTableTableManager(_db, _db.lessonResults);
}
