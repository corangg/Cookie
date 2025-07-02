class AppAssets {
  static const icOven = 'assets/icons/ic_oven.png';
  static const icCollection = 'assets/icons/ic_collection.png';
  static const icProfile = 'assets/icons/ic_profile.png';

  static const imgTray = 'assets/img/img_oven_tray.png';
  static const imgMessagePaper = 'assets/img/img_message_paper.png';
  static const imgCookieNormal1 = 'assets/img/img_cookie_normal_1.png';
  static const imgCookieCheering1 = 'assets/img/img_cookie_cheering_1.png';
  static const imgCookieCheering2 = 'assets/img/img_cookie_cheering_2.png';
  static const imgCookieCheering3 = 'assets/img/img_cookie_cheering_3.png';
  static const imgCookieCheering4 = 'assets/img/img_cookie_cheering_4.png';
  static const imgCookieCheering5 = 'assets/img/img_cookie_cheering_5.png';
  static const imgCookieCheering6 = 'assets/img/img_cookie_cheering_6.png';
  static const imgCookieComfort1 = 'assets/img/img_cookie_comfort_1.png';
  static const imgCookieComfort2 = 'assets/img/img_cookie_comfort_2.png';
  static const imgCookieComfort3 = 'assets/img/img_cookie_comfort_3.png';
  static const imgCookieComfort4 = 'assets/img/img_cookie_comfort_4.png';
  static const imgCookieComfort5 = 'assets/img/img_cookie_comfort_5.png';
  static const imgCookieComfort6 = 'assets/img/img_cookie_comfort_6.png';
  static const imgCookiePassion1 = 'assets/img/img_cookie_passion_1.png';
  static const imgCookiePassion2 = 'assets/img/img_cookie_passion_2.png';
  static const imgCookiePassion3 = 'assets/img/img_cookie_passion_3.png';
  static const imgCookiePassion4 = 'assets/img/img_cookie_passion_4.png';
  static const imgCookiePassion5 = 'assets/img/img_cookie_passion_5.png';
  static const imgCookiePassion6 = 'assets/img/img_cookie_passion_6.png';
  static const imgCookieSermon1 = 'assets/img/img_cookie_sermon_1.png';
  static const imgCookieDisable = 'assets/img/img_cookie_disable.png';

  static const imgCollectionCheering = 'assets/img/img_collection_cheering.png';
  static const imgCollectionCheeringHalf = 'assets/img/img_collection_cheering_half.png';
  static const imgCollectionBackground = 'assets/img/img_collection_background.png';
  static const imgCollectionBackgroundTop = 'assets/img/img_collection_background_top.png';
  static const imgCollectionNo = 'assets/img/img_collection_no.png';

  static String imgTypeOpenCookie(int type) {
    return switch (type) {
      1 => imgCookieCheering6,
      2 => imgCookieComfort6,
      3 => imgCookiePassion6,
      _ => imgCookieDisable,
    };
  }
}