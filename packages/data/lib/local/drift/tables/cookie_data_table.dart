import 'package:data/local/drift/converter/cookie_data_converter.dart';
import 'package:drift/drift.dart';

@DataClassName('LocalCookieData')
class CookieDataTable extends Table {
  DateTimeColumn get date  => dateTime().clientDefault(() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  })();

  TextColumn get infos => text().map(const CookieInfoListConverter())();

  @override
  Set<Column> get primaryKey => {date};
}