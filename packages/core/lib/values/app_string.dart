class AppStrings {
  static const appTitle = '쿠키';

  //label
  static const labelBottomNavigationBarOven = 'oven';
  static const labelBottomNavigationBarCollection = 'collection';
  static const labelBottomNavigationBarProfile = 'profile';

  //button
  static const buttonOk = '확인';

  //message
  static const allCollectionMessage = '모든 쿠키를 수집 했어요!';
  static const errorCookieMessage = '죄송합니다. 오류가 발생했어요';


  static List<String> getCookieMessageList(int type) {
    return switch (type){
      1 => AppStrings.cheeringCollectionList,
      2 => AppStrings.comfortCollectionList,
      3 => AppStrings.passionCollectionList,
      4 => AppStrings.sermonCollectionList,
      5 => AppStrings.cheeringCollectionList,
      _ => throw ArgumentError('알 수 없는 CookieType: $type'),
    };
  }

  static List<String> cheeringCollectionList = [
    'cheeringTest1',
    'cheeringTest2',
    'cheeringTest3',
    'cheeringTest4',
    'cheeringTest5',
    'cheeringTest6',
    'cheeringTest7',
    'cheeringTest8',
    'cheeringTest9',
    'cheeringTest10',
    'cheeringTest11',
    'cheeringTest12',
  ];

  static List<String> comfortCollectionList = [
    'test2',
  ];

  static List<String> passionCollectionList = [
    'test3',
  ];

  static List<String> sermonCollectionList = [
    'test4',
  ];
}