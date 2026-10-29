// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EmotionEntriesTableTable extends EmotionEntriesTable
    with TableInfo<$EmotionEntriesTableTable, EmotionEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmotionEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emotionNameMeta = const VerificationMeta(
    'emotionName',
  );
  @override
  late final GeneratedColumn<String> emotionName = GeneratedColumn<String>(
    'emotion_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intensityMeta = const VerificationMeta(
    'intensity',
  );
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
    'intensity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    emotionName,
    intensity,
    timestamp,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emotion_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmotionEntriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('emotion_name')) {
      context.handle(
        _emotionNameMeta,
        emotionName.isAcceptableOrUnknown(
          data['emotion_name']!,
          _emotionNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emotionNameMeta);
    }
    if (data.containsKey('intensity')) {
      context.handle(
        _intensityMeta,
        intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta),
      );
    } else if (isInserting) {
      context.missing(_intensityMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmotionEntriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmotionEntriesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      emotionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emotion_name'],
      )!,
      intensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intensity'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $EmotionEntriesTableTable createAlias(String alias) {
    return $EmotionEntriesTableTable(attachedDatabase, alias);
  }
}

class EmotionEntriesTableData extends DataClass
    implements Insertable<EmotionEntriesTableData> {
  final String id;
  final String emotionName;
  final int intensity;
  final DateTime timestamp;
  final String? note;
  const EmotionEntriesTableData({
    required this.id,
    required this.emotionName,
    required this.intensity,
    required this.timestamp,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['emotion_name'] = Variable<String>(emotionName);
    map['intensity'] = Variable<int>(intensity);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  EmotionEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return EmotionEntriesTableCompanion(
      id: Value(id),
      emotionName: Value(emotionName),
      intensity: Value(intensity),
      timestamp: Value(timestamp),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory EmotionEntriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmotionEntriesTableData(
      id: serializer.fromJson<String>(json['id']),
      emotionName: serializer.fromJson<String>(json['emotionName']),
      intensity: serializer.fromJson<int>(json['intensity']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'emotionName': serializer.toJson<String>(emotionName),
      'intensity': serializer.toJson<int>(intensity),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'note': serializer.toJson<String?>(note),
    };
  }

  EmotionEntriesTableData copyWith({
    String? id,
    String? emotionName,
    int? intensity,
    DateTime? timestamp,
    Value<String?> note = const Value.absent(),
  }) => EmotionEntriesTableData(
    id: id ?? this.id,
    emotionName: emotionName ?? this.emotionName,
    intensity: intensity ?? this.intensity,
    timestamp: timestamp ?? this.timestamp,
    note: note.present ? note.value : this.note,
  );
  EmotionEntriesTableData copyWithCompanion(EmotionEntriesTableCompanion data) {
    return EmotionEntriesTableData(
      id: data.id.present ? data.id.value : this.id,
      emotionName: data.emotionName.present
          ? data.emotionName.value
          : this.emotionName,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmotionEntriesTableData(')
          ..write('id: $id, ')
          ..write('emotionName: $emotionName, ')
          ..write('intensity: $intensity, ')
          ..write('timestamp: $timestamp, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, emotionName, intensity, timestamp, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmotionEntriesTableData &&
          other.id == this.id &&
          other.emotionName == this.emotionName &&
          other.intensity == this.intensity &&
          other.timestamp == this.timestamp &&
          other.note == this.note);
}

class EmotionEntriesTableCompanion
    extends UpdateCompanion<EmotionEntriesTableData> {
  final Value<String> id;
  final Value<String> emotionName;
  final Value<int> intensity;
  final Value<DateTime> timestamp;
  final Value<String?> note;
  final Value<int> rowid;
  const EmotionEntriesTableCompanion({
    this.id = const Value.absent(),
    this.emotionName = const Value.absent(),
    this.intensity = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmotionEntriesTableCompanion.insert({
    required String id,
    required String emotionName,
    required int intensity,
    required DateTime timestamp,
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       emotionName = Value(emotionName),
       intensity = Value(intensity),
       timestamp = Value(timestamp);
  static Insertable<EmotionEntriesTableData> custom({
    Expression<String>? id,
    Expression<String>? emotionName,
    Expression<int>? intensity,
    Expression<DateTime>? timestamp,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (emotionName != null) 'emotion_name': emotionName,
      if (intensity != null) 'intensity': intensity,
      if (timestamp != null) 'timestamp': timestamp,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmotionEntriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? emotionName,
    Value<int>? intensity,
    Value<DateTime>? timestamp,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return EmotionEntriesTableCompanion(
      id: id ?? this.id,
      emotionName: emotionName ?? this.emotionName,
      intensity: intensity ?? this.intensity,
      timestamp: timestamp ?? this.timestamp,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (emotionName.present) {
      map['emotion_name'] = Variable<String>(emotionName.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmotionEntriesTableCompanion(')
          ..write('id: $id, ')
          ..write('emotionName: $emotionName, ')
          ..write('intensity: $intensity, ')
          ..write('timestamp: $timestamp, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EmotionEntriesTableTable emotionEntriesTable =
      $EmotionEntriesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [emotionEntriesTable];
}

typedef $$EmotionEntriesTableTableCreateCompanionBuilder =
    EmotionEntriesTableCompanion Function({
      required String id,
      required String emotionName,
      required int intensity,
      required DateTime timestamp,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$EmotionEntriesTableTableUpdateCompanionBuilder =
    EmotionEntriesTableCompanion Function({
      Value<String> id,
      Value<String> emotionName,
      Value<int> intensity,
      Value<DateTime> timestamp,
      Value<String?> note,
      Value<int> rowid,
    });

class $$EmotionEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $EmotionEntriesTableTable> {
  $$EmotionEntriesTableTableFilterComposer({
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

  ColumnFilters<String> get emotionName => $composableBuilder(
    column: $table.emotionName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmotionEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EmotionEntriesTableTable> {
  $$EmotionEntriesTableTableOrderingComposer({
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

  ColumnOrderings<String> get emotionName => $composableBuilder(
    column: $table.emotionName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmotionEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmotionEntriesTableTable> {
  $$EmotionEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get emotionName => $composableBuilder(
    column: $table.emotionName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$EmotionEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmotionEntriesTableTable,
          EmotionEntriesTableData,
          $$EmotionEntriesTableTableFilterComposer,
          $$EmotionEntriesTableTableOrderingComposer,
          $$EmotionEntriesTableTableAnnotationComposer,
          $$EmotionEntriesTableTableCreateCompanionBuilder,
          $$EmotionEntriesTableTableUpdateCompanionBuilder,
          (
            EmotionEntriesTableData,
            BaseReferences<
              _$AppDatabase,
              $EmotionEntriesTableTable,
              EmotionEntriesTableData
            >,
          ),
          EmotionEntriesTableData,
          PrefetchHooks Function()
        > {
  $$EmotionEntriesTableTableTableManager(
    _$AppDatabase db,
    $EmotionEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmotionEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmotionEntriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EmotionEntriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> emotionName = const Value.absent(),
                Value<int> intensity = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmotionEntriesTableCompanion(
                id: id,
                emotionName: emotionName,
                intensity: intensity,
                timestamp: timestamp,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String emotionName,
                required int intensity,
                required DateTime timestamp,
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EmotionEntriesTableCompanion.insert(
                id: id,
                emotionName: emotionName,
                intensity: intensity,
                timestamp: timestamp,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmotionEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmotionEntriesTableTable,
      EmotionEntriesTableData,
      $$EmotionEntriesTableTableFilterComposer,
      $$EmotionEntriesTableTableOrderingComposer,
      $$EmotionEntriesTableTableAnnotationComposer,
      $$EmotionEntriesTableTableCreateCompanionBuilder,
      $$EmotionEntriesTableTableUpdateCompanionBuilder,
      (
        EmotionEntriesTableData,
        BaseReferences<
          _$AppDatabase,
          $EmotionEntriesTableTable,
          EmotionEntriesTableData
        >,
      ),
      EmotionEntriesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EmotionEntriesTableTableTableManager get emotionEntriesTable =>
      $$EmotionEntriesTableTableTableManager(_db, _db.emotionEntriesTable);
}
