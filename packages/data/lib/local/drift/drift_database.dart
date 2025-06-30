import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/drift_entity.dart';
import 'tables/cookie_data_table.dart';
import 'tables/collection_data_table.dart';
import 'converter/cookie_data_converter.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [CookieDataTable, CollectionDataTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  factory AppDatabase.open() {
    return AppDatabase(
      LazyDatabase(() async {
        final dir = await getApplicationDocumentsDirectory();
        final file = File(p.join(dir.path, 'cookie.sqlite'));
        return NativeDatabase.createInBackground(file);
      }),
    );
  }

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 2) {
        await m.createTable(collectionDataTable);
      }
    },
  );

  Future<void> upsertCookie(LocalCookieData entry) {
    return into(cookieDataTable).insertOnConflictUpdate(entry);
  }

  Future<List<LocalCookieData>> getAllData() {
    return select(cookieDataTable).get();
  }

  Future<LocalCookieData?> getCookieData(DateTime targetDate) {
    final normalized = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );
    return (select(
      cookieDataTable,
    )..where((t) => t.date.equals(normalized))).getSingleOrNull();
  }

  Stream<LocalCookieData?> getTodayCookieDataStream() {
    final now = DateTime.now();
    final norm = DateTime(now.year, now.month, now.day);
    return (select(cookieDataTable)
      ..where((t) => t.date.equals(norm)))
        .watchSingleOrNull();
  }

  Future<void> upsertCollection(LocalCollectionData entry) {
    return into(collectionDataTable).insertOnConflictUpdate(entry);
  }

  Future<List<LocalCollectionData>> getCollectionData(int targetType) {
    return (select(collectionDataTable)..where((tbl) => tbl.type.equals(targetType))).get();
  }

  Stream<List<LocalCollectionData>> getCollectionDataStream() {
    return select(collectionDataTable).watch();
  }
}