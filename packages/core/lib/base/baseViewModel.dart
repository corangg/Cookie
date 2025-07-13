import 'package:core/values/app_string.dart';
import 'package:flutter/cupertino.dart';

typedef AsyncAction = Future<void> Function();

abstract class BaseViewModel extends ChangeNotifier {
  bool isLoading = false;
  String? error;

  Future<void> onWork(AsyncAction action) async {
    isLoading = true;
    notifyListeners();

    try {
      await action();
    } catch (e) {
      final baseErrorMessage = AppStrings.viewModelErrorMessage;
      error = '$baseErrorMessage $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}