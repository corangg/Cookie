import 'package:domain/model/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:domain/usecases/cookie_usecase.dart';

class OvenScreenViewModel extends ChangeNotifier {
  final GetCookieDataUseCase getUseCase;
  final UpsertCookieDataUseCase upsertUseCase;

  CookieData? cookie;
  bool isLoading = false;
  String? error;

  OvenScreenViewModel({
    required this.getUseCase,
    required this.upsertUseCase,
  });

  Future<void> load(String dateString) async {
    isLoading = true;
    notifyListeners();

    try {
      cookie = await getUseCase.call(dateString);
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
}