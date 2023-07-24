// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../app_colors.dart';

AppBar SlashAppBar(double screenWidth, double screenHeight) {
  return AppBar(
    backgroundColor: backgroundBlack,
    elevation: 0,
    title: Text(
      'Slash /.',
      style: TextStyle(
          fontSize: screenHeight/20,
          color: mainWhite
      ),
    ),
    actions: [Icon(Icons.account_circle_sharp, size: screenWidth*screenHeight/11000), SizedBox(width: screenWidth/20)],
  );
}