import 'dart:async';

import 'package:core/base/base_view_model.dart';
import 'package:core/util/util.dart';
import 'package:domain/model/models.dart';
import 'package:domain/usecases/collection_usecase.dart';
import 'package:domain/usecases/cookie_usecase.dart';

class OvenScreenViewModel extends BaseViewModel {
  final GetCookieDataUseCase getUseCase;
  final UpsertCookieDataUseCase upsertCookieDataUseCase;
  final UpdateOpenCookieDataUseCase updateOpenCookieDataUseCase;
  final GetTodayCookieDataUseCase getTodayCookieDataUseCase;
  final CreateNewCollectionNoUseCase createNewCollectionNoUseCase;
  final UpsertCollectionUseCase upsertCollectionUseCase;
  StreamSubscription<CookieData>? _todaySub;

  CookieData cookie;

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

  Future<void> _startTodayListener() {
    return onWork(() async {
      _todaySub = getTodayCookieDataUseCase().listen((data) {
        cookie = data;
        isLoading = false;
        notifyListeners();
      });
    });
  }

  Future<void> updateDateCookieInfo(CookieType type) {
    return onWork(() async {
      final cookieInfo = DateCookieInfo(type: type, isOpened: true, no: newCookieNo ?? -1);
      updateOpenCookieDataUseCase(cookieInfo);
    });
  }

  Future<void> generateNewCookieNo(CookieType type, int collectionSize) {
    return onWork(() async {
      final no = await createNewCollectionNoUseCase(type, collectionSize);
      _newCookieNo = no;
    });
  }

  Future<void> upsertCollectionData(CookieType type) {
    return onWork(() async {
      final data = CollectionData(type: type, no: newCookieNo ?? -1, date: createTodayDate(),);
      await upsertCollectionUseCase(data);
    });
  }

  Future<void> upsertTodayCookie() {
    return onWork(() async {
      final cookie = CookieData.empty();
      upsertCookieDataUseCase(cookie);
    });
  }

  void setNewCookieNo(int no){
    _newCookieNo = no;
  }

  @override
  void dispose() {
    _todaySub?.cancel();
    super.dispose();
  }
}