// ignore_for_file: non_constant_identifier_names

import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slash_eval/app_colors.dart';
import 'package:slash_eval/data.dart';
import 'package:slash_eval/screens/common/app_bar.dart';
import 'package:slash_eval/screens/dashboard/components/analytics_select_button.dart';
import 'package:slash_eval/screens/dashboard/components/graph/bar_data.dart';
import 'package:slash_eval/screens/dashboard/components/graph/bar_graph.dart';
import 'package:slash_eval/screens/dashboard/components/info_card.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});
  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late final double earnings;
  late final int orders;
  late final Map<String, List<Map<String, dynamic>>> purchaseData;
  @override

  void initState() {
    purchaseData = PurchaseData.getData();
    List<dynamic> result = calculateEarningsAndOrders(purchaseData);
    earnings = result[0];
    orders = result[1];
    super.initState();
  }

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
        backgroundColor: mainGrey,
        appBar: SlashAppBar(screenWidth, screenHeight),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                HeaderText('Your Earnings', screenHeight/25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InfoCard(
                        title: 'Earnings',
                        value: CurrencyFormatter.format(earnings, compact: true, CurrencyFormatterSettings(
                            symbol: '£',
                            symbolSeparator: '',
                            thousandSeparator: '.'
                        )),
                        icon: Icons.attach_money_outlined
                    ),

                    InfoCard(
                        title: 'Orders',
                        value: orders.toString(),
                        icon: Icons.shopping_bag
                    )
                  ],
                ),
              ],
            ),

            Column(
              children: [
                HeaderText('Analytics', screenHeight/25),
                Container(
                  padding: EdgeInsets.symmetric(vertical: screenHeight/30, horizontal: screenWidth/20),
                  decoration: BoxDecoration(
                      color: foregroundBlack,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly Earnings',
                        style: TextStyle(
                            fontSize: screenHeight/35,
                            fontWeight: FontWeight.bold,
                            color: lightGrey
                        ),
                      ),

                      Container(
                          margin: EdgeInsets.only(top: screenHeight/40),
                          width: screenWidth/1.25,
                          height: screenHeight/4,
                          child: BarGraph(barData: BarData(displayType: DisplayType.monthly, data: purchaseData))
                      )
                    ],
                  )
                )
              ],
            ),

            AnalyticsSelectButton()
          ],
        ),
      ),
    );
  }

  List<dynamic> calculateEarningsAndOrders(Map<String, List<Map<String, dynamic>>> data) {
    double earnings = 0.0;
    int orders = 0;
    for (String day in data.keys) {
      orders += data[day]!.length;
      for (Map<String, dynamic> order in data[day]!) {
        earnings += order['price'];
      }
    }
    print(earnings);
    return [earnings, orders];
  }

  Padding HeaderText(String text, double size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: size,
              color: mainWhite
            ),
          ),
        ],
      ),
    );
  }
}
