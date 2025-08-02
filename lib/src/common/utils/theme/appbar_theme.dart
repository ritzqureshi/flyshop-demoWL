import 'package:flutter/material.dart';

import '../colours.dart';

class TAppBarTheme {
  TAppBarTheme._();
  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: MyColors.transparent,
    surfaceTintColor: MyColors.transparent,
    iconTheme: IconThemeData(color: MyColors.black, size: 24),
    actionsIconTheme: IconThemeData(color: MyColors.black, size: 24),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: MyColors.black,
    ),
  ); // AppBarTheme
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: MyColors.transparent,
    surfaceTintColor: MyColors.transparent,
    iconTheme: IconThemeData(color: MyColors.black, size: 24),
    actionsIconTheme: IconThemeData(color: MyColors.white, size: 24),
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: MyColors.white,
    ),
  ); // AppBarTheme
}
