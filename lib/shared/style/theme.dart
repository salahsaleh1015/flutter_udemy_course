import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udemy_course/shared/style/colors.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600)),
    // primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: HexColor("333739"),
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.white, size: 26),
        color: HexColor("333739"),
        elevation: 0.0,
        backwardsCompatibility: false,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor("333739"),
          statusBarIconBrightness: Brightness.light,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor("333739"),
      unselectedIconTheme: IconThemeData(color: Colors.grey),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      elevation: 10,
    ));
ThemeData lightTheme = ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
        caption: TextStyle(fontSize: 16)),

    // primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        actionsIconTheme: IconThemeData(color: Colors.black, size: 26),
        color: Colors.white,
        elevation: 0.0,
        backwardsCompatibility: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      elevation: 10,
    ));
