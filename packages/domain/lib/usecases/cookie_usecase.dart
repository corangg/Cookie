import 'package:domain/model/models.dart';
import 'package:domain/repository/repository.dart';

class GetCookieDataUseCase {
  final Repository _repo;
  GetCookieDataUseCase(this._repo);

  Future<CookieData?> call(String dateString) {
    return _repo.getCookieData(dateString);
  }
}

class UpsertCookieDataUseCase {
  final Repository _repo;
  UpsertCookieDataUseCase(this._repo);

  Future<void> call(CookieData data) {
    return _repo.upsertCookieData(data);
  }
}