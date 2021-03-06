import 'package:Expenseye/Resources/Themes/app_colors.dart';
import 'package:flutter/material.dart';

class MyThemeData {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: MaterialColor(
      0xff38C6B9,
      const <int, Color>{
        50: const Color(0xff38C6B9),
        100: const Color(0xff38C6B9),
        200: const Color(0xff38C6B9),
        300: const Color(0xff38C6B9),
        400: const Color(0xff38C6B9),
        500: const Color(0xff38C6B9),
        600: const Color(0xff38C6B9),
        700: const Color(0xff38C6B9),
        800: const Color(0xff38C6B9),
        900: const Color(0xff38C6B9),
      },
    ),
    iconTheme: IconThemeData(color: Colors.black),
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.grey[200],
      disabledColor: Colors.grey[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    buttonColor: Colors.grey[200],
    primaryColor: Colors.grey[100],
    backgroundColor: Colors.white,
    dialogBackgroundColor: Colors.white,
    focusColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.grey[100],
    accentColor: AppDarkThemeColors.secondaryDarker,
    disabledColor: Colors.grey[100],
    hintColor: Colors.grey[500],
    indicatorColor: AppDarkThemeColors.secondary,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppDarkThemeColors.secondary,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 32, color: Colors.black),
      headline2: TextStyle(color: Colors.black),
      headline3: TextStyle(color: Colors.black),
      headline4: TextStyle(color: Colors.black),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      subtitle1: TextStyle(color: Colors.black),
      subtitle2: TextStyle(color: Colors.black),
      bodyText1: TextStyle(color: Colors.black),
      bodyText2: TextStyle(color: Colors.black),
      caption: TextStyle(color: Colors.grey),
      button: TextStyle(color: Colors.black),
      overline: TextStyle(color: Colors.black),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(
      0xff33B4A8,
      const <int, Color>{
        50: const Color(0xff33B4A8),
        100: const Color(0xff33B4A8),
        200: const Color(0xff33B4A8),
        300: const Color(0xff33B4A8),
        400: const Color(0xff33B4A8),
        500: const Color(0xff33B4A8),
        600: const Color(0xff33B4A8),
        700: const Color(0xff33B4A8),
        800: const Color(0xff33B4A8),
        900: const Color(0xff33B4A8),
      },
    ),
    iconTheme: IconThemeData(color: Colors.white),
    buttonTheme: ButtonThemeData(
      buttonColor: AppDarkThemeColors.black06dp,
      disabledColor: AppDarkThemeColors.black01dp,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    buttonColor: AppDarkThemeColors.black06dp,
    primaryColor: AppDarkThemeColors.black02dp,
    backgroundColor: AppDarkThemeColors.black00dp,
    scaffoldBackgroundColor: AppDarkThemeColors.black00dp,
    cardColor: AppDarkThemeColors.black03dp,
    cardTheme: CardTheme(
      color: AppDarkThemeColors.black03dp,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    accentColor: AppDarkThemeColors.secondaryDarker,
    disabledColor: AppDarkThemeColors.black01dp,
    hintColor: AppDarkThemeColors.black24dp,
    indicatorColor: AppDarkThemeColors.secondary,
    dialogBackgroundColor: AppDarkThemeColors.black00dp,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppDarkThemeColors.secondary,
    ),
    focusColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(fontSize: 32, color: Colors.white),
      headline2: TextStyle(color: Colors.white),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
      headline5: TextStyle(color: Colors.white),
      headline6: TextStyle(color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
      subtitle2: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
      caption: TextStyle(color: Colors.grey),
      button: TextStyle(color: Colors.white),
      overline: TextStyle(color: Colors.white),
    ),
  );
}
