import 'package:domain/model/models.dart';

abstract class Repository {
  Future<void> upsertCookieData(CookieData data);

  Future<CookieData?> getCookieData(String dateString);

  Stream<CookieData?> getTodayCookieDataStream();
}