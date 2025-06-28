import 'package:data/local/drift/drift_database.dart';

abstract class LocalDataSource {
  Future<void> upsertCookieData(LocalCookieData data);
  Future<List<LocalCookieData>> getAllCookieData();
  Future<LocalCookieData?> getCookieData(DateTime date);
  Stream<LocalCookieData?> getTodayCookieDataStream();

  Future<void> upsertCollectionData(LocalCollectionData data);
  Future<List<LocalCollectionData>> getCollectionData(int targetType);
  Stream<List<LocalCollectionData>> getCollectionDataStream();
}