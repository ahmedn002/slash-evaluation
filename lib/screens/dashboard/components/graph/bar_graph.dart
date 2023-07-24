import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:slash_eval/app_colors.dart';

class BarGraph extends StatefulWidget {
  const BarGraph({super.key});

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(BarChartData(
      backgroundColor: mainWhite
    ));
  }
}
