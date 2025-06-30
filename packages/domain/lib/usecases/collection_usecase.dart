import 'dart:ffi';
import 'dart:math';

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
      return newCollectionNoList[idx] -1;
    } else {
      return -1;
    }
  }
}

class  UpsertCollectionUseCase {
  final Repository _repo;
  UpsertCollectionUseCase(this._repo);

  Future<void> call(CollectionData data) {
    return _repo.upsertCollectionData(data);
  }
}