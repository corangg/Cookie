import 'package:data/local/drift/drift_database.dart';
import 'package:data/local/drift/tables/drift_entity.dart';
import 'package:domain/model/models.dart';

extension CookieDataToLocal on CookieData {
  LocalCookieData toLocal() {
    final localInfos = infos
        .map((info) => info.toLocalDateCookieInfo())
        .toList();

    return LocalCookieData(date: date, infos: localInfos);
  }
}

extension DateCookieInfoMapper on DateCookieInfo {
  LocalDateCookieInfo toLocalDateCookieInfo() {
    return LocalDateCookieInfo(type: type.code, isOpened: isOpened, no: no);
  }
}

extension CookieDataToExternal on LocalCookieData {
  CookieData toExternal() {
    final date = this.date;

    final infos = this.infos.map((localInfo) {
      final cookieType = switch (localInfo.type) {
        1 => const CookieType.cheering(),
        2 => const CookieType.comfort(),
        3 => const CookieType.passion(),
        4 => const CookieType.sermon(),
        5 => const CookieType.random(),
        _ => throw ArgumentError('알 수 없는 CookieType 코드: ${localInfo.type}'),
      };

      return DateCookieInfo(
        type: cookieType,
        isOpened: localInfo.isOpened,
        no: localInfo.no,
      );
    }).toList();

    return CookieData(date: date, infos: infos);
  }
}
