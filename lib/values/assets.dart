import 'package:core/values/app_assets.dart';
import 'package:domain/model/models.dart';

class CookieAssets{
  static final List<CookieImageAssetsData> cookieImageDataList = [
    CookieImageAssetsData(
      AppAssets.imgCookieCheering1,
      AppAssets.imgCookieCheering2,
      AppAssets.imgCookieCheering3,
      AppAssets.imgCookieCheering4,
      AppAssets.imgCookieCheering5,
      AppAssets.imgCookieCheering6,
    ),
    CookieImageAssetsData(
      AppAssets.imgCookieComfort1,
      AppAssets.imgCookieComfort2,
      AppAssets.imgCookieComfort3,
      AppAssets.imgCookieComfort4,
      AppAssets.imgCookieComfort5,
      AppAssets.imgCookieComfort6,
    ),
    CookieImageAssetsData(
      AppAssets.imgCookiePassion1,
      AppAssets.imgCookiePassion2,
      AppAssets.imgCookiePassion3,
      AppAssets.imgCookiePassion4,
      AppAssets.imgCookiePassion5,
      AppAssets.imgCookiePassion6,
    ),
    CookieImageAssetsData(
      AppAssets.imgCookieSermon1,
      AppAssets.imgCookieSermon2,
      AppAssets.imgCookieSermon3,
      AppAssets.imgCookieSermon4,
      AppAssets.imgCookieSermon5,
      AppAssets.imgCookieSermon6,
    )
  ];

  static final List<MoreItemData> moreItemList = [
    MoreItemData(item: '수집률', iconAsset: AppAssets.icCollectionLate, itemType: MoreItemType.collectionLate()),
    MoreItemData(item: '앱 정보', iconAsset: AppAssets.icInfo, itemType: MoreItemType.aboutApp()),
    MoreItemData(item: '테마', iconAsset: AppAssets.icTheme, itemType: MoreItemType.theme()),
  ];
}