import 'package:flutter/material.dart';

typedef IntCallback = void Function(int value);

DateTime stringToDateTime(String dateString) {
  final year = int.parse(dateString.substring(0, 4));
  final month = int.parse(dateString.substring(4, 6));
  final day = int.parse(dateString.substring(6, 8));
  return DateTime(year, month, day);
}

DateTime createTodayDate() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

DateTime getTodayMidnight() {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  return today.add(const Duration(days: 1));
}

DateTime getNextMidnight() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day + 1);
}

double getAppBarHeight(BuildContext context){
  final scaffoldState = Scaffold.of(context);
  return scaffoldState.appBarMaxHeight ?? kToolbarHeight;
}