import 'package:data/local/drift/drift_database.dart';
import 'package:domain/model/models.dart';

extension LocalToDomain on LocalCookieData {
  CookieData toDomain() => CookieData(
    date,
    isCheeringOpened,
    cheeringNo,
    isComportOpened,
    comportNo,
    isPassionOpened,
    passionNo,
    isSermonOpened,
    sermonNo,
    isRandomsOpened,
    randomNo,
  );
}

extension DomainToLocal on CookieData {
  LocalCookieData toLocal() => LocalCookieData(
    date: date,
    isCheeringOpened: isCheeringOpened,
    cheeringNo: cheeringNo,
    isComportOpened: isComportOpened,
    comportNo: comportNo,
    isPassionOpened: isPassionOpened,
    passionNo: passionNo,
    isSermonOpened: isSermonOpened,
    sermonNo: sermonNo,
    isRandomsOpened: isRandomsOpened,
    randomNo: randomNo,
  );
}