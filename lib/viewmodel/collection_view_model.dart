import 'dart:async';

import 'package:domain/extension/extension.dart';
import 'package:domain/model/models.dart';
import 'package:domain/usecases/collection_usecase.dart';
import 'package:flutter/material.dart';

class CollectionViewModel extends ChangeNotifier {
  final GetTypeCollectionDataUseCase getTypeCollectionDataUseCase;
  final FillCollectionDataListUseCase fillCollectionDataListUseCase;

  List<CollectionData> _collectionList = [];
  List<CollectionData> get collectionList => _collectionList;

  CollectionViewType viewType = CollectionViewTypeNo();

  bool isLoading = false;
  String? error;

  CollectionViewModel({
    required this.getTypeCollectionDataUseCase,
    required this.fillCollectionDataListUseCase
  });

  Future<void> setCollectionList(CookieType type) async {
    isLoading = true;
    notifyListeners();
    try {
      final localList = await getTypeCollectionDataUseCase(type);
      _collectionList = fillCollectionDataListUseCase(localList, type);
      notifyListeners();
    } catch (e) {
      error = 'collectionData 가져오기 실패: $e';
      isLoading = false;
      notifyListeners();
    }
    finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void sortByList() {
    switch (viewType.code) {
      case 1:collectionList.sortByNo();
      case 2 :collectionList.sortByDate();
      case _ :throw ArgumentError('알 수 없는 CollectionViewType 코드: ${viewType.code}');
    }
  }

  void setCollectionViewType(CollectionViewType type){
    viewType = type;
  }
}