import 'dart:async';

import 'package:domain/model/models.dart';
import 'package:domain/usecases/collection_usecase.dart';
import 'package:flutter/material.dart';
import 'package:domain/extension/extension.dart';

class CollectionViewModel extends ChangeNotifier {
  final GetTypeCollectionDataUseCase getTypeCollectionDataUseCase;
  final FillCollectionDataListUseCase fillCollectionDataListUseCase;

  List<CollectionData> collectionList = [];

  CollectionViewType viewType = CollectionViewType.no();

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
      if(viewType == CollectionViewType.no()){
       localList.sortByNo();
      }else if(viewType == CollectionViewType.date()){
        localList.sortByDate();
      }
      collectionList = localList;
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