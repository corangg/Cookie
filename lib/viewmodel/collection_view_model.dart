import 'dart:async';

import 'package:domain/model/models.dart';
import 'package:domain/usecases/collection_usecase.dart';
import 'package:flutter/material.dart';
import 'package:domain/extension/extension.dart';

class CollectionViewModel extends ChangeNotifier {
  final GetTypeCollectionDataUseCase getTypeCollectionDataUseCase;
  final FillCollectionDataListUseCase fillCollectionDataListUseCase;

  List<CollectionData> collectionList = [];

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
      final localList = await getTypeCollectionDataUseCase.call(type);
      final fillList = fillCollectionDataListUseCase.call(localList, type);
      switch (viewType.code){
        case 1:fillList.sortByNo();
        case 2 : fillList.sortByDate();
        case _ :throw ArgumentError('알 수 없는 CollectionViewType 코드: ${viewType.code}');
      }
      collectionList = fillList;
    } catch (e) {
      error = 'collectionData 가져오기 실패: $e';
    }
    finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setCollectionViewType(CollectionViewType type){
    viewType = type;
  }
}