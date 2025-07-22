import 'dart:async';

import 'package:core/base/base_view_model.dart';
import 'package:domain/extension/extension.dart';
import 'package:domain/model/models.dart';
import 'package:domain/usecases/collection_usecase.dart';

class CollectionViewModel extends BaseViewModel {
  final GetTypeCollectionDataUseCase getTypeCollectionDataUseCase;
  final FillCollectionDataListUseCase fillCollectionDataListUseCase;

  List<CollectionData> _collectionList = [];
  List<CollectionData> get collectionList => _collectionList;

  CollectionViewType viewType = CollectionViewTypeNo();

  CollectionViewModel({
    required this.getTypeCollectionDataUseCase,
    required this.fillCollectionDataListUseCase
  });

  Future<void> setCollectionList(CookieType type) {
    return onWork(() async {
      final localList = await getTypeCollectionDataUseCase(type);
      _collectionList = fillCollectionDataListUseCase(localList, type);
    });
  }

  void sortByList() {
    switch (viewType.code) {
      case 1 :collectionList.sortByNo();break;
      case 2 :collectionList.sortByDate();break;
      case _ :throw ArgumentError('알 수 없는 CollectionViewType 코드: ${viewType.code}');
    }
    notifyListeners();
  }

  void setCollectionViewType(CollectionViewType type){
    viewType = type;
  }
}