// import 'dart:io';
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:emora/models/emotion_entry.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
// import 'package:flutter/material.dart';

// Define the table schema
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:emora/models/emotion_entry.dart';
part 'app_database.g.dart'; // Must be right here at the top!

class EmotionEntriesTable extends Table {
  TextColumn get id => text()();
  TextColumn get emotionName => text()();
  IntColumn get intensity => integer()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [EmotionEntriesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Stream all entries reactively
  Stream<List<EmotionEntry>> watchAllEntries() {
    return select(emotionEntriesTable).watch().map((rows) {
      return rows.map((row) {
        return EmotionEntry(
          id: row.id,
          emotion: EmotionType.values.firstWhere(
            (e) => e.name == row.emotionName,
            orElse: () => EmotionType.happy,
          ),
          intensity: row.intensity,
          timestamp: row.timestamp,
          note: row.note,
        );
      }).toList();
    });
  }

  // Insert entry
  Future<void> insertEntry(EmotionEntry entry) async {
    into(emotionEntriesTable).insert(
      EmotionEntriesTableCompanion.insert(
        id: entry.id,
        emotionName: entry.emotion.name,
        intensity: entry.intensity,
        timestamp: entry.timestamp,
        note: Value(entry.note),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  // Delete entry
  Future<void> deleteEntry(String id) async {
    await (delete(emotionEntriesTable)..where((t) => t.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'emotion_database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
