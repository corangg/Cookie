DateTime stringToDateTime(String dateString) {
  final year = int.parse(dateString.substring(0, 4));
  final month = int.parse(dateString.substring(4, 6));
  final day = int.parse(dateString.substring(6, 8));
  return DateTime(year, month, day);
}
