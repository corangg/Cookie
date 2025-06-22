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