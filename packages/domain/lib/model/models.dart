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

class CookieData {
  final DateTime date;
  final bool isCheeringOpened;
  final int cheeringNo;
  final bool isComportOpened;
  final int comportNo;
  final bool isPassionOpened;
  final int passionNo;
  final bool isSermonOpened;
  final int sermonNo;
  final bool isRandomsOpened;
  final int randomNo;

  const CookieData(
    this.date,
    this.isCheeringOpened,
    this.cheeringNo,
    this.isComportOpened,
    this.comportNo,
    this.isPassionOpened,
    this.passionNo,
    this.isSermonOpened,
    this.sermonNo,
    this.isRandomsOpened,
    this.randomNo,
  );
  factory CookieData.empty() {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    return CookieData(
      midnight,
      false, -1,
      false, -1,
      false, -1,
      false, -1,
      false, -1,
    );
  }
}