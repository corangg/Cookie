import 'dart:async';

import 'package:core/values/app_size.dart';
import 'package:domain/model/models.dart';
import 'package:domain/usecases/collection_usecase.dart';
import 'package:domain/usecases/cookie_usecase.dart';
import 'package:flutter/cupertino.dart';

class OvenScreenViewModel extends ChangeNotifier {
  final GetCookieDataUseCase getUseCase;
  final UpsertCookieDataUseCase upsertUseCase;
  final GetTodayCookieDataUseCase getTodayCookieDataUseCase;
  final CreateNewCollectionNoUseCase createNewCollectionNoUseCase;
  StreamSubscription<CookieData>? _todaySub;

  CookieData cookie;
  bool isLoading = false;
  String? error;

  int? _newCookieNo;
  int? get newCookieNo => _newCookieNo;

  OvenScreenViewModel({
    required this.getUseCase,
    required this.upsertUseCase,
    required this.getTodayCookieDataUseCase,
    required this.createNewCollectionNoUseCase
  }) : cookie = CookieData.empty() {
    _startTodayListener();
  }

  void _startTodayListener() {
    isLoading = true;
    notifyListeners();

    _todaySub = getTodayCookieDataUseCase.call().listen(
          (data) {
        // data is guaranteed non-null
        cookie = data;
        isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        error = '오늘 데이터 스트림 오류: $e';
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> load(String dateString) async {
    isLoading = true;
    notifyListeners();

    try {
       cookie = await getUseCase.call(dateString);
       error = null;
    } catch (e) {
      error = '불러오기 실패: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> save(CookieData data) async {
    isLoading = true;
    notifyListeners();

    try {
      await upsertUseCase.call(data);
      cookie = data;
    } catch (e) {
      error = '저장 실패: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateDateCookieInfo(DateCookieInfo info) async {
    info.isOpened;
    1;
  }

  Future<void> generateNewCookieNo(CookieType type) async {
    isLoading = true;
    notifyListeners();
    try {
      final no = await createNewCollectionNoUseCase(type, AppSize.collectionMaxNo);
      _newCookieNo = no;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _todaySub?.cancel();
    super.dispose();
  }
}