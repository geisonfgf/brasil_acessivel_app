import 'package:flutter/material.dart';
import 'layout/theme.dart';
import 'pages/home.dart';
import 'pages/login.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Home(),
  "/login": (BuildContext context) => Login(),
};

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: routes
    )
  );
}