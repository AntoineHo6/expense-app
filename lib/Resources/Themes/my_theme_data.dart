import 'package:Expenseye/Resources/Themes/MyColors.dart';
import 'package:flutter/material.dart';

class MyThemeData {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: Colors.white),
    buttonTheme: ButtonThemeData(
      buttonColor: MyColors.black06dp,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    primaryColor: MyColors.black02dp,
    backgroundColor: MyColors.black00dp,
    dialogBackgroundColor: MyColors.black00dp,
    scaffoldBackgroundColor: MyColors.black00dp,
    cardColor: MyColors.black06dp,
    accentColor: MyColors.secondaryDarker,
    hintColor: MyColors.black24dp,
    disabledColor: MyColors.secondaryDisabled,
    indicatorColor: MyColors.secondary,
    bottomAppBarColor: MyColors.black24dp,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MyColors.secondary,
    ),
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
