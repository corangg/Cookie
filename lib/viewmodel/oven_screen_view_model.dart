import 'dart:async';

import 'package:core/util/util.dart';
import 'package:domain/model/models.dart';
import 'package:domain/usecases/collection_usecase.dart';
import 'package:domain/usecases/cookie_usecase.dart';
import 'package:flutter/cupertino.dart';

class OvenScreenViewModel extends ChangeNotifier {
  final GetCookieDataUseCase getUseCase;
  final UpsertCookieDataUseCase upsertCookieDataUseCase;
  final UpdateOpenCookieDataUseCase updateOpenCookieDataUseCase;
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
    required this.upsertCookieDataUseCase,
    required this.updateOpenCookieDataUseCase,
    required this.getTodayCookieDataUseCase,
    required this.createNewCollectionNoUseCase,
    required this.upsertCollectionUseCase
  }) : cookie = CookieData.empty() {
    _startTodayListener();
  }

  void _startTodayListener() {
    isLoading = true;
    notifyListeners();

    _todaySub = getTodayCookieDataUseCase.call().listen((data) {
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

  Future<void> updateDateCookieInfo(CookieType type) async {
    isLoading = true;
    notifyListeners();

    final cookieInfo = DateCookieInfo(type: type, isOpened: true, no: newCookieNo ?? -1);

    try {
      updateOpenCookieDataUseCase.call(cookieInfo);
    } catch (e) {
      error = '업데이트 실패: $e';
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

  Future<void> upsertCollectionData(CookieType type) async {
    isLoading = true;
    notifyListeners();
    try {
      final collectionData = CollectionData(type: type, no: newCookieNo?? -1 , date: createTodayDate());
      upsertCollectionUseCase.call(collectionData);

    } catch (e) {
      error = 'Collection Upsert Failed: $e';
    } finally {
      isLoading=false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _todaySub?.cancel();
    super.dispose();
  }
}