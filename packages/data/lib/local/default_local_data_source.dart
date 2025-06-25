
import 'package:data/data_source/local_data_source.dart';
import 'package:data/local/drift/drift_database.dart';

class DefaultLocalDataSource implements LocalDataSource {
  final AppDatabase _db;
  DefaultLocalDataSource(this._db);
  @override
  Future<void> upsertCookieData(LocalCookieData entry) => _db.upsertCookie(entry);

  @override
  Future<List<LocalCookieData>> getAllCookieData() => _db.getAllData();

  @override
  Future<LocalCookieData?> getCookieData(DateTime date) => _db.getCookieData(date);

  @override
  Stream<LocalCookieData?> getTodayCookieDataStream() => _db.getTodayCookieDataStream();
}