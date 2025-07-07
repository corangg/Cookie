import 'dart:math';

import 'package:core/values/app_string.dart';
import 'package:domain/model/models.dart';
import 'package:domain/repository/repository.dart';

class CreateNewCollectionNoUseCase {
  final Repository _repo;
  CreateNewCollectionNoUseCase(this._repo);
  Future<int> call(CookieType type, int maxNo) async {
    final collection = await _repo.getCollectionData(type.code);
    final collectionNoListSet = collection.map((e) => e.no).toList().toSet();
    final newCollectionNoList = List.generate(maxNo, (i) => i + 1).where((n) => !collectionNoListSet.contains(n)).toList();

    if (newCollectionNoList.isNotEmpty) {
      final idx = Random().nextInt(newCollectionNoList.length);
      return newCollectionNoList[idx];
    } else {
      return -1;
    }
  }
}

class UpsertCollectionUseCase {
  final Repository _repo;
  UpsertCollectionUseCase(this._repo);

  Future<void> call(CollectionData data) {
    return _repo.upsertCollectionData(data);
  }
}

class GetTypeCollectionDataUseCase {
  final Repository _repo;

  GetTypeCollectionDataUseCase(this._repo);

  Future<List<CollectionData>> call(CookieType cookieType) async {
    final list = await _repo.getCollectionData(cookieType.code);
    return list.where((data) => data.type == cookieType).toList();
  }
}

class FillCollectionDataListUseCase {
  List<CollectionData> call(List<CollectionData> list, CookieType cookieType) {
    final collectionSize = AppStrings.getCookieMessageList(cookieType.code).length;
    final source = list.length > collectionSize ? list.sublist(0, collectionSize) : list;
    final now = DateTime.now();
    final List<CollectionData> fillList = [];
    for (int i = 0; i < collectionSize; i++) {
      final data = source.firstWhere((data) => data.no == i + 1, orElse: () => CollectionData(type: CookieType.unCollected(), no: i + 1, date: now,));
      fillList.add(data);
    }
    return fillList;
  }
}