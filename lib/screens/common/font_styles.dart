import 'package:flutter/material.dart';

class FontStyles {
  static double _ratio = 750 * 1334;

  static late final TextStyle? appBarStyle;

  static void init(screenWidth, screenHeight) {
    _ratio = screenWidth * screenHeight;

    appBarStyle = TextStyle(
      fontSize: _ratio / 15000
    );
  }
}