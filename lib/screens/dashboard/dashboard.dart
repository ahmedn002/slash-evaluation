import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slash_eval/app_colors.dart';
import 'package:slash_eval/screens/common/app_bar.dart';
import 'package:slash_eval/screens/dashboard/components/info_card.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme
        )
      ),
      home: Scaffold(
        backgroundColor: backgroundBlack,
        appBar: SlashAppBar(screenWidth, screenHeight),
        body: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'Earnings', value: 500.23, icon: Icons.attach_money_outlined, isPrice: true),
                InfoCard(title: 'Orders', value: 100, icon: Icons.shopping_bag, isPrice: false)
              ],
            )
          ],
        ),
      ),
    );
  }
}
