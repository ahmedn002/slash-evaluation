import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slash_eval/app_colors.dart';
import 'package:slash_eval/data.dart';
import 'package:slash_eval/screens/common/app_bar.dart';
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
  @override
  void initState() {
    List<dynamic> result = calculateEarningsAndOrders(PurchaseData.getData());
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
        backgroundColor: backgroundBlack,
        appBar: SlashAppBar(screenWidth, screenHeight),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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

            SizedBox(height: screenHeight/3, child: BarGraph())
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
}
