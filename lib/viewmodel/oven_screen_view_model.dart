import 'dart:async';

import 'package:domain/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:domain/usecases/cookie_usecase.dart';

class OvenScreenViewModel extends ChangeNotifier {
  final GetCookieDataUseCase getUseCase;
  final UpsertCookieDataUseCase upsertUseCase;
  final GetTodayCookieDataUseCase getTodayCookieDataUseCase;
  StreamSubscription<CookieData>? _todaySub;

  CookieData cookie;
  bool isLoading = false;
  String? error;

  OvenScreenViewModel({
    required this.getUseCase,
    required this.upsertUseCase,
    required this.getTodayCookieDataUseCase,
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

  @override
  void dispose() {
    _todaySub?.cancel();
    super.dispose();
  }
}