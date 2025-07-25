import 'package:core/base/base_view_model.dart';
import 'package:domain/model/models.dart';
import 'package:domain/usecases/collection_usecase.dart';

class MoreScreenViewModel extends BaseViewModel {
  final GetTypeCollectionDataUseCase getTypeCollectionDataUseCase;

  MoreScreenViewModel({
    required this.getTypeCollectionDataUseCase,
  });

  Future<List<int>> getCollectionLate(int itemsSize) async {
    final List<int> collectionLateList = [];
    await onWork(() async {
      for (int i = 0; i < itemsSize; i++) {
        final list = await getTypeCollectionDataUseCase(
          CookieType.fromCode(i + 1),
        );
        collectionLateList.add(list.length);
      }
    });

    return List.unmodifiable(collectionLateList);
  }
}