import 'package:core/util/util.dart';
import 'package:data/data_source/local_data_source.dart';
import 'package:data/mapper/mapper.dart';
import 'package:domain/model/models.dart';
import 'package:domain/repository/repository.dart';

class DefaultRepository implements Repository {
  final LocalDataSource _ds;
  DefaultRepository(this._ds);

  @override
  Future<void> upsertCookieData(CookieData data) async {
    final localData = data.toLocal();
    await _ds.upsertCookieData(localData);
  }

  @override
  Future<CookieData?> getCookieData(String dateString) async {
    final date = stringToDateTime(dateString);
    final localCookieData = await _ds.getCookieData(date);
    return localCookieData?.toExternal();
  }

  @override
  Stream<CookieData?> getTodayCookieDataStream() {
    return _ds.getTodayCookieDataStream().asyncMap((local) async {
      if (local == null) {
        final todayCookieData = CookieData.empty();
        await upsertCookieData(todayCookieData);
        return todayCookieData;
      }
      return local.toExternal();
    });
  }
}