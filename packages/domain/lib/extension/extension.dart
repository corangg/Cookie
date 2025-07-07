import 'package:domain/model/models.dart';

extension CollectionNoDataSort on List<CollectionData> {
  void sortByNo() => sort((a, b) => a.no.compareTo(b.no));
}

extension CollectionDataSort on List<CollectionData> {
  void sortByDate() {
    sort((a, b) {
      final dateCmp = a.date.compareTo(b.date);
      if (dateCmp != 0) {
        return dateCmp;
      }
      return a.no.compareTo(b.no);
    });
  }
}
