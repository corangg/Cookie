
import 'package:drift/drift.dart';

@DataClassName('LocalCollectionData')
class CollectionDataTable extends Table {
  IntColumn get type => integer()();

  IntColumn get no => integer()();

  DateTimeColumn get date => dateTime().clientDefault(() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  })();

  @override
  Set<Column> get primaryKey => {type, no};
}