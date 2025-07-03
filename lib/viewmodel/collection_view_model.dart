import 'dart:async';

import 'package:domain/model/models.dart';
import 'package:domain/usecases/collection_usecase.dart';
import 'package:flutter/material.dart';

class CollectionViewModel extends ChangeNotifier {
  final GetTypeCollectionDataUseCase getTypeCollectionDataUseCase;

  List<CollectionData> collectionList = [];


  bool isLoading = false;
  String? error;

  CollectionViewModel({
    required this.getTypeCollectionDataUseCase
  });

  Future<void> setCollectionList(CookieType type) async {
    isLoading = true;
    notifyListeners();
    try {
      collectionList = await getTypeCollectionDataUseCase(type);
    } catch (e) {
      error = 'collectionData 가져오기 실패: $e';
    }
    finally {
      isLoading = false;
      notifyListeners();
    }
  }
}