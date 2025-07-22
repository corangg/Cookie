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

sealed class CollectionViewType {
  final int code;
  const CollectionViewType(this.code);

  const factory CollectionViewType.no() =  CollectionViewTypeNo;
  const factory CollectionViewType.date() =  CollectionViewTypeDate;

  static CollectionViewType fromCode(int code) {
    return switch (code) {
      1 => const CollectionViewType.no(),
      2 => const CollectionViewType.date(),
      _ => throw ArgumentError('알 수 없는 CollectionViewType 코드: $code'),
    };
  }
}

final class CollectionViewTypeNo extends CollectionViewType {
  const CollectionViewTypeNo(): super(1);
}
final class CollectionViewTypeDate extends CollectionViewType {
  const CollectionViewTypeDate(): super(2);
}

class MoreItemData {
  final String item;
  final String iconAsset;
  final MoreItemType itemType;

  const MoreItemData({
    required this.item,
    required this.iconAsset,
    required this.itemType
  });
}

sealed class MoreItemType {
  final int code;
  const MoreItemType(this.code);

  const factory MoreItemType.profile() = MoreItemTypeProfile;
  const factory MoreItemType.theme() = MoreItemTypeTheme;
  const factory MoreItemType.collectionLate() = MoreItemTypeCollectionLate;
  const factory MoreItemType.aboutApp() = MoreItemTypeAboutApp;
  const factory MoreItemType.logOut() = MoreItemTypeLogOut;

  static MoreItemType fromCode(int code) {
    return switch (code) {
      1 => const MoreItemType.profile(),
      2 => const MoreItemType.theme(),
      3 => const MoreItemType.collectionLate(),
      4 => const MoreItemType.aboutApp(),
      5 => const MoreItemType.logOut(),
      _ => throw ArgumentError('알 수 없는 MoreItemType 코드: $code'),
    };
  }
}

final class MoreItemTypeProfile extends MoreItemType {
  const MoreItemTypeProfile() : super(1);
}

final class MoreItemTypeTheme extends MoreItemType {
  const MoreItemTypeTheme() : super(2);
}

final class MoreItemTypeCollectionLate extends MoreItemType {
  const MoreItemTypeCollectionLate() : super(3);
}

final class MoreItemTypeAboutApp extends MoreItemType {
  const MoreItemTypeAboutApp() : super(4);
}

final class MoreItemTypeLogOut extends MoreItemType {
  const MoreItemTypeLogOut() : super(5);
}