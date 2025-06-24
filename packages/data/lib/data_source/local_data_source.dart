import 'package:data/local/drift/drift_database.dart';

abstract class LocalDataSource {
  Future<void> upsertCookieData(LocalCookieData data);
  Future<List<LocalCookieData>> getAllCookieData();
  Future<LocalCookieData?> getCookieData(DateTime date);
}