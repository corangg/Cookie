class NavItemData {
  final String asset;
  final bool isProfile;

  const NavItemData(this.asset, {this.isProfile = false});
}

class CookieButtonData {
  final double top;
  final double left;
  final double? right;
  final bool isOpened;
  //final String asset;

  const CookieButtonData({
    required this.top,
    required this.isOpened,
    this.left = 0,
    this.right,
  });
}

class CookieImageAssetsData {
  final String trayCookie;
  final String catchCookie;
  final String crackCookie;
  final String halfOpenCookie;
  final String openCookie;
  final String crushCookie;

  const CookieImageAssetsData(
    this.trayCookie,
    this.catchCookie,
    this.crackCookie,
    this.halfOpenCookie,
    this.openCookie,
    this.crushCookie,
  );
}

class OpenCookieUIData {
  final double screenWidth;
  final double screenHeight;
  final CookieImageAssetsData cookieStateData;

  const OpenCookieUIData(
    this.screenWidth,
    this.screenHeight,
    this.cookieStateData,
  );
}

class DateCookieInfo {
  final CookieType type;
  final bool isOpened;
  final int no;

  const DateCookieInfo({
    required this.type,
    required this.isOpened,
    required this.no,
  });
}

class CookieData {
  final DateTime date;
  final List<DateCookieInfo> infos;

  const CookieData({required this.date, required this.infos});

  factory CookieData.empty() {
    final now = DateTime.now();
    final yyyyMMDD = DateTime(now.year, now.month, now.day);

    return CookieData(
      date: yyyyMMDD,
      infos: const [
        DateCookieInfo(type: CookieType.cheering(), isOpened: false, no: -1),
        DateCookieInfo(type: CookieType.comfort(), isOpened: false, no: -1),
        DateCookieInfo(type: CookieType.passion(), isOpened: false, no: -1),
        DateCookieInfo(type: CookieType.sermon(), isOpened: false, no: -1),
        DateCookieInfo(type: CookieType.random(), isOpened: false, no: -1),
      ],
    );
  }
}

sealed class CookieType {
  final int code;
  const CookieType(this.code);

  const factory CookieType.cheering() =  CookieTypeCheering;
  const factory CookieType.comfort() =  CookieTypeComfort;
  const factory CookieType.passion() =  CookieTypePassion;
  const factory CookieType.sermon() =  CookieTypeSermon;
  const factory CookieType.random() =  CookieTypeRandom;
  const factory CookieType.unCollected() =  CookieTypeUnCollected;

  static CookieType fromCode(int code) {
    return switch (code) {
      1 => const CookieType.cheering(),
      2 => const CookieType.comfort(),
      3 => const CookieType.passion(),
      4 => const CookieType.sermon(),
      5 => const CookieType.random(),
      6 => const CookieType.unCollected(),
      _ => throw ArgumentError('알 수 없는 CookieType 코드: $code'),
    };
  }
}

final class CookieTypeCheering extends CookieType {
  const CookieTypeCheering(): super(1);
}
final class CookieTypeComfort extends CookieType {
  const CookieTypeComfort(): super(2);
}
final class CookieTypePassion extends CookieType {
  const CookieTypePassion(): super(3);
}
final class CookieTypeSermon extends CookieType {
  const CookieTypeSermon(): super(4);
}
final class CookieTypeRandom extends CookieType {
  const CookieTypeRandom(): super(5);
}

final class CookieTypeUnCollected extends CookieType {
  const CookieTypeUnCollected(): super(6);
}

class CollectionData {
  final CookieType type;
  final int no;
  final DateTime date;

  const CollectionData({
    required this.type,
    required this.no,
    required this.date,
  });
}