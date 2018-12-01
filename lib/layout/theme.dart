import 'package:flutter/material.dart';

const kPrimaryColorLight = Color.fromRGBO(128, 0, 128, 1.0);
const kSecondColorLight = Color.fromRGBO(255, 555, 255, 1.0);
const kGreenColor = Color.fromRGBO(154, 189, 25, 1.0);

ThemeData buildThemeData() {
  final baseTheme = ThemeData.light();

  return baseTheme.copyWith(
    primaryColor: kPrimaryColorLight,
    accentColor: kSecondColorLight
  );
}