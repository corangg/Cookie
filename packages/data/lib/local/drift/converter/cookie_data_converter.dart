import 'dart:convert';

import 'package:data/local/drift/tables/drift_entity.dart';
import 'package:drift/drift.dart';

class CookieInfoListConverter
    extends TypeConverter<List<LocalDateCookieInfo>, String> {
  const CookieInfoListConverter();

  @override
  List<LocalDateCookieInfo> fromSql(String fromDb) {
    final List<dynamic> jsonList = jsonDecode(fromDb);
    return jsonList.map((e) {
      final m = e as Map<String, dynamic>;
      return LocalDateCookieInfo(
        type:     m['type']     as int,
        isOpened: m['isOpened'] as bool,
        no:       m['no']       as int,
      );
    }).toList();
  }

  @override
  String toSql(List<LocalDateCookieInfo> value) {
    final jsonList = value.map((e) => {
      'type':     e.type,
      'isOpened': e.isOpened,
      'no':       e.no,
    }).toList();
    return jsonEncode(jsonList);
  }
}