import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/login.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Home(),
  "/login": (BuildContext context) => Login(),
};

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(primaryColor: Colors.red, accentColor: Colors.redAccent),
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: routes
    )
  );
}