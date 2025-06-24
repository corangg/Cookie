import 'package:drift/drift.dart';

@DataClassName("LocalCookieData")
class CookieDataTable extends Table {
  DateTimeColumn get date => dateTime().clientDefault(() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  })();

  BoolColumn get isCheeringOpened => boolean().withDefault(const Constant(false))();
  IntColumn get cheeringNo => integer().withDefault(const Constant(-1))();
  BoolColumn get isComportOpened => boolean().withDefault(const Constant(false))();
  IntColumn get comportNo => integer().withDefault(const Constant(-1))();
  BoolColumn get isPassionOpened => boolean().withDefault(const Constant(false))();
  IntColumn get passionNo => integer().withDefault(const Constant(-1))();
  BoolColumn get isSermonOpened => boolean().withDefault(const Constant(false))();
  IntColumn get sermonNo => integer().withDefault(const Constant(-1))();
  BoolColumn get isRandomsOpened => boolean().withDefault(const Constant(false))();
  IntColumn get randomNo => integer().withDefault(const Constant(-1))();

  @override
  Set<Column> get primaryKey => {date};
}