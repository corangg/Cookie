import 'package:core/util/util.dart';
import 'package:data/data_source/local_data_source.dart';
import 'package:domain/model/models.dart';
import 'package:domain/repository/repository.dart';
import 'package:data/mapper/mapper.dart';

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
    return localCookieData?.toDomain();
  }
}