import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slash_eval/screens/common/font_styles.dart';

import '../../app_colors.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  double screenWidth = 750;
  double screenHeight = 1334;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.outfitTextTheme(
          Theme.of(context).textTheme.apply(
            displayColor: mainWhite,
            bodyColor: mainWhite
          )
        )
      ),
      home: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          // backgroundColor: background,
          elevation: 0,
          title: Text(
            'Slash /.',
            style: FontStyles.appBarStyle,
          ),
        ),
      ),
    );
  }
}
