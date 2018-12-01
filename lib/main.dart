import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/login.dart';

void main() {
  final _routes = <String, WidgetBuilder>{
    "/home": (BuildContext context) => Home(),
    "/login": (BuildContext context) => Login(),
  };

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Ruboto',
        primaryColor: Colors.white,
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.cyan)
        ),
        primaryIconTheme: IconThemeData(color: Colors.purple)
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: _routes
    )
  );
}