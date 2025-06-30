import 'package:core/util/util.dart';
import 'package:domain/model/models.dart';
import 'package:domain/repository/repository.dart';

class GetCookieDataUseCase {
  final Repository _repo;
  GetCookieDataUseCase(this._repo);

  Future<CookieData> call(DateTime date) async {
    return (await _repo.getCookieData(date)) ?? CookieData.empty();
  }
}

class UpsertCookieDataUseCase {
  final Repository _repo;
  UpsertCookieDataUseCase(this._repo);

  Future<void> call(CookieData data) {
    return _repo.upsertCookieData(data);
  }
}

class UpdateOpenCookieDataUseCase {
  final Repository _repo;
  UpdateOpenCookieDataUseCase(this._repo);

  Future<void> call(DateCookieInfo openCookieInfo) async {
    final date = createTodayDate();
    final todayCookieData = await _repo.getCookieData(date);

    if (todayCookieData == null) {
      return;
    } else {
      final CookieData updateData = CookieData(
          date: todayCookieData.date,
          infos: todayCookieData.infos.map((info) => info.type == openCookieInfo.type ? openCookieInfo : info).toList()
      );

      return _repo.upsertCookieData(updateData);
    }
  }
}

class GetTodayCookieDataUseCase {
  final Repository _repo;
  GetTodayCookieDataUseCase(this._repo);

  Stream<CookieData> call(){
    return _repo.getTodayCookieDataStream().map((cookie) => cookie ?? CookieData.empty());
  }
}