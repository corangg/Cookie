import 'dart:async';

import 'package:core/util/util.dart';
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
  final UpsertCollectionUseCase upsertCollectionUseCase;
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
    required this.createNewCollectionNoUseCase,
    required this.upsertCollectionUseCase
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
    //newCode 와 타입, date, isOpened 를 업데이트
    info.isOpened;
    1;
  }

  Future<void> testUpsertCollection() async {
    isLoading = true;
    notifyListeners();
    try {
      CollectionData data = CollectionData(type: CookieType.random(), no: -1, date: createTodayDate());
      await upsertCollectionUseCase.call(data);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> generateNewCookieNo(CookieType type, int collectionSize) async {
    isLoading = true;
    notifyListeners();
    try {
      final no = await createNewCollectionNoUseCase(type, collectionSize);
      _newCookieNo = no;
    }catch (e) {
      error = '생성 실패: $e';
    }  finally {
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