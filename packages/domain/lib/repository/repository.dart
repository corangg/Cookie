import 'package:domain/model/models.dart';

abstract class Repository {
  Future<void> upsertCookieData(CookieData data);

  Future<CookieData?> getCookieData(DateTime dateString);

  Stream<CookieData?> getTodayCookieDataStream();

  Future<void> upsertCollectionData(CollectionData data);

  Future<List<CollectionData>> getCollectionData(int type);

  Stream<List<CollectionData>> getCollectionDataStream();
}