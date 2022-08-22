import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

var dark = ThemeData(
    iconTheme: IconThemeData(color: Colors.deepOrange),
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
    scaffoldBackgroundColor: HexColor("333739"),
    primarySwatch: Colors.deepOrange,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange,
        focusColor: Colors.red,
        hoverColor: Colors.green),
    appBarTheme: AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor("333739"),
            statusBarIconBrightness: Brightness.light),
        backgroundColor: HexColor("333739"),
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.white)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        backgroundColor: HexColor("333739"),
        elevation: 20.0));

var light = ThemeData(
    textTheme: const TextTheme(
        bodyText1: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
    primarySwatch: Colors.deepOrange,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange,
        focusColor: Colors.red,
        hoverColor: Colors.green),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 20.0));
