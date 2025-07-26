import 'package:flutter/material.dart';

class AppColor {
  static const mainBackground = Color(0xFFFFE5A0);
  static const translucentBackground = Color(0x77000000);
  static const mainButtonBackground = Color(0xFFFBB11B);
  static const mainButtonBorder = Color(0xFF4D310E);

  static const bottomNavigationBarIconBackground = Color(0xFFF5B82B);
  static const bottomNavigationBarIcon = Color(0xFFF5B82B);
  static const bottomNavigationBarBorder = Color(0xFF593714);

  static const spinnerBackground = Color(0xFFEEB85E);
  static const checkboxCheck = Color(0xFFEEB85E);

  static const collectionCookieButton = Color(0xFFEEB85E);

  static const countDown = Color(0x99888888);

  static const mainTextColor = Color(0xFF593714);
  static const defaultOverlay = Color(0xFFF5B82B);
  static const defaultOverlayBorder = Color(0xFF593714);

  static const cheeringMain = Color(0xFF43ACF6);
  static const comfortMain = Color(0xFFFAEACA);
  static const passionMain = Color(0xFFFF840C);
  static const sermonMain = Color(0xFF774927);
  static const loveMain = Color(0xFFF7C0BF);
  static const errorMain = Color(0xFF969696);


  static Color cookieTypeMainColor(int type) {
    return switch (type) {
      1 => cheeringMain,
      2 => comfortMain,
      3 => passionMain,
      4 => sermonMain,
      _ => errorMain,
    };
  }
}