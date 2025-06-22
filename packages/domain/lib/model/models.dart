class NavItemData {
  final String asset;
  final bool isProfile;

  const NavItemData(this.asset, {this.isProfile = false});
}

class CookieButtonData {
  final double top;
  final double left;
  final double? right;
  final String asset;

  const CookieButtonData({
    required this.top,
    required this.asset,
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