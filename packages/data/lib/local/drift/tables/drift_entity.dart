import 'dart:ffi';

class LocalDateCookieInfo {
  final int type;
  final bool isOpened;
  final int no;

  const LocalDateCookieInfo({
    required this.type,
    required this.isOpened,
    required this.no,
  });
}