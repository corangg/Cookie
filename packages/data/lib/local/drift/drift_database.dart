import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/cookie_data_table.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [CookieDataTable])
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
  int get schemaVersion => 1;

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
}