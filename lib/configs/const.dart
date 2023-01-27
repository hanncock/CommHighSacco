import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color primaryColor = Color.fromRGBO(255, 0, 0, 1); //.fromRGBO(255, 82, 48, 1);

class Constants {
  static String appName = "Social Connect";

  // Colors for theme
  static Color lightPrimary = Color(0xfffcfcff);
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.blue;
  static Color darkAccent = Colors.blueAccent;
  static Color lightBg = Color(0xfffcfcff);
  static Color darkBg = Colors.black;
  static Color badgeColor = Colors.red;

  static ThemeData lightTheme = ThemeData(
      backgroundColor: lightBg,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      // cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBg,
      appBarTheme: AppBarTheme(
          elevation: 0,
          textTheme: TextTheme(
              headline6: TextStyle(
                  color: darkBg,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800))));
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      backgroundColor: darkBg,
      primaryColor: darkPrimary,
      accentColor: darkAccent,
      scaffoldBackgroundColor: darkBg,
      // cursorColor: darkAccent,
      appBarTheme: AppBarTheme(
          elevation: 0,
          textTheme: TextTheme(
              headline6: TextStyle(
                  color: lightBg,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800))));
}

const SERVER_URL = 'http://168.235.82.130:8081/Xe/api/';
const API_BASE_URL = "http://168.235.82.130:8274/"; // SERVER_URL + 'mobile/';
const AUTH_URL = "http://168.235.82.130:8274/";


