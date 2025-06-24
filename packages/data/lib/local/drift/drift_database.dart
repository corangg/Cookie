import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/cookie_data.dart';

part 'drift_database.g.dart';

@DriftDatabase(tables: [CookieDataTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> upsertCookie(LocalCookieData entry) {
    return into(cookieDataTable).insertOnConflictUpdate(entry);
  }

  Future<List<LocalCookieData>> getAllData() {
    return select(cookieDataTable).get();
  }

  Future<LocalCookieData?> getKeywordData(DateTime targetDate) {
    final normalized = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );
    return (select(cookieDataTable)
      ..where((t) => t.date.equals(normalized)))
        .getSingleOrNull();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'cookie.sqlite'));
    return NativeDatabase(file);
  });
}