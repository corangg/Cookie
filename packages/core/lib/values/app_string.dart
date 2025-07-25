class AppStrings {
  static const appTitle = '쿠키';

  static const privacyPolicyTitle = '개인 정보 처리 방침';
  static const privacyPolicy = '해당 앱은 개인 정보를 수집, 이용 하지 않습니다.';

  //label
  static const labelBottomNavigationBarOven = 'oven';
  static const labelBottomNavigationBarCollection = 'collection';
  static const labelBottomNavigationBarProfile = 'profile';

  //button
  static const buttonOk = '확인';

  //message
  static const allCollectionMessage = '모든 쿠키를 수집 했어요!';
  static const errorCookieMessage = '죄송합니다. 오류가 발생했어요';
  static const updateCookieTitleMessage = '새로운 쿠키가 준비 됐어요!';
  static const updateCookieBodyMessage = '지금 바로 새로우 쿠키를 확인해 보세요!';
  static const updateCookieMessage = '새로운 쿠키가 준비 됐어요. 쿠키를 확인해 보세요!';
  static const viewModelErrorMessage = 'work Error:';
  static const unCollectedCookieMessage = '아직 수집 하지 못한 쿠키 에요';

  static const textShowCollectionCookie = '수집한 쿠키만 보기';

  //description
  static const notificationDefaultChannelDescription = '앱의 일반 알림 채널';

  static List<String> viewTypeList = ['번호', '획득 날짜'];

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

  static String getCookieType(int type) {
    return switch (type){
      1 => '응원',
      2 => '위로',
      3 => '열정',
      4 => '결심',
      5 => '',
      _ => throw ArgumentError('알 수 없는 CookieType: $type'),
    };
  }

  static List<String> cheeringCollectionList = [
    'cheeringTest1',
    'cheeringTest2',
    'cheeringTest3',
    '가나다라',
    'cheeringTest5',
    'cheeringTest6',
    'cheeringTest7',
    'cheeringTest8',
    'cheeringTest9',
    'cheeringTest10',
    'cheeringTest11',
    'cheeringTest12',
    'cheeringTest13',
    'cheeringTest14',
    'cheeringTest15',
    'cheeringTest16',
    'cheeringTest17',
    'cheeringTest18',
    'cheeringTest19',
    'cheeringTest20',
    'cheeringTest21',
    'cheeringTest22',
    'cheeringTest23',
    'cheeringTest24',
    'cheeringTest25',
    '마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하',
    'cheeringTest27',
    'cheeringTest28',
    'cheeringTest29',
    'cheeringTest30',
    /*'cheeringTest1',
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
    'cheeringTest13',
    'cheeringTest14',
    'cheeringTest15',
    'cheeringTest16',
    'cheeringTest17',
    'cheeringTest18',
    'cheeringTest19',
    'cheeringTest20',
    'cheeringTest21',
    'cheeringTest22',
    'cheeringTest23',
    'cheeringTest24',
    'cheeringTest25',
    'cheeringTest26',
    'cheeringTest27',
    'cheeringTest28',
    'cheeringTest29',
    'cheeringTest30',
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
    'cheeringTest13',
    'cheeringTest14',
    'cheeringTest15',
    'cheeringTest16',
    'cheeringTest17',
    'cheeringTest18',
    'cheeringTest19',
    'cheeringTest20',
    'cheeringTest21',
    'cheeringTest22',
    'cheeringTest23',
    'cheeringTest24',
    'cheeringTest25',
    'cheeringTest26',
    'cheeringTest27',
    'cheeringTest28',
    'cheeringTest29',
    'cheeringTest30',
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
    'cheeringTest13',
    'cheeringTest14',
    'cheeringTest15',
    'cheeringTest16',
    'cheeringTest17',
    'cheeringTest18',
    'cheeringTest19',
    'cheeringTest20',
    'cheeringTest21',
    'cheeringTest22',
    'cheeringTest23',
    'cheeringTest24',
    'cheeringTest25',
    'cheeringTest26',
    'cheeringTest27',
    'cheeringTest28',
    'cheeringTest29',
    'cheeringTest30',
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
    'cheeringTest13',
    'cheeringTest14',
    'cheeringTest15',
    'cheeringTest16',
    'cheeringTest17',
    'cheeringTest18',
    'cheeringTest19',
    'cheeringTest20',
    'cheeringTest21',
    'cheeringTest22',
    'cheeringTest23',
    'cheeringTest24',
    'cheeringTest25',
    'cheeringTest26',
    'cheeringTest27',
    'cheeringTest28',
    'cheeringTest29',
    'cheeringTest30',
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
    'cheeringTest13',
    'cheeringTest14',
    'cheeringTest15',
    'cheeringTest16',
    'cheeringTest17',
    'cheeringTest18',
    'cheeringTest19',
    'cheeringTest20',
    'cheeringTest21',
    'cheeringTest22',
    'cheeringTest23',
    'cheeringTest24',
    'cheeringTest25',
    'cheeringTest26',
    'cheeringTest27',
    'cheeringTest28',
    'cheeringTest29',
    'cheeringTest30',*/
  ];

  static List<String> comfortCollectionList = [
    'comfortTest1',
    'comfortTest2',
    'comfortTest3',
    'comfortTest4',
    'comfortTest5',
    'comfortTest6',
    'comfortTest7',
    'comfortTest8',
    'comfortTest9',
    'comfortTest10',
    'comfortTest11',
    'comfortTest12',
    'comfortTest13',
    'comfortTest14',
    'comfortTest15',
    'comfortTest16',
    'comfortTest17',
    'comfortTest18',
    'comfortTest19',
    'comfortTest20',
    'comfortTest21',
    'comfortTest22',
    'comfortTest23',
    'comfortTest24',
    'comfortTest25',
    'comfortTest26',
    'comfortTest27',
    'comfortTest28',
    'comfortTest29',
    'comfortTest30',
  ];

  static List<String> passionCollectionList = [
    'passionTest1',
    'passionTest2',
    'passionTest3',
    'passionTest4',
    'passionTest5',
    'passionTest6',
    'passionTest7',
    'passionTest8',
    'passionTest9',
    'passionTest10',
    'passionTest11',
    'passionTest12',
    'passionTest13',
    'passionTest14',
    'passionTest15',
    'passionTest16',
    'passionTest17',
    'passionTest18',
    'passionTest19',
    'passionTest20',
    'passionTest21',
    'passionTest22',
    'passionTest23',
    'passionTest24',
    'passionTest25',
    'passionTest26',
    'passionTest27',
    'passionTest28',
    'passionTest29',
    'passionTest30',
  ];

  static List<String> sermonCollectionList = [
    'sermonTest1',
    'sermonTest2',
    'sermonTest3',
    'sermonTest4',
    'sermonTest5',
    'sermonTest6',
    'sermonTest7',
    'sermonTest8',
    'sermonTest9',
    'sermonTest10',
    'sermonTest11',
    'sermonTest12',
    'sermonTest13',
    'sermonTest14',
    'sermonTest15',
    'sermonTest16',
    'sermonTest17',
    'sermonTest18',
    'sermonTest19',
    'sermonTest20',
    'sermonTest21',
    'sermonTest22',
    'sermonTest23',
    'sermonTest24',
    'sermonTest25',
    'sermonTest26',
    'sermonTest27',
    'sermonTest28',
    'sermonTest29',
    'sermonTest30',
  ];
}