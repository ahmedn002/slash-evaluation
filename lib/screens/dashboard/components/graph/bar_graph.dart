import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:slash_eval/app_colors.dart';
import 'package:slash_eval/screens/dashboard/components/graph/bar_data.dart';

class BarGraph extends StatefulWidget {
  final BarData barData;
  const BarGraph({super.key, required this.barData});

  @override
  State<BarGraph> createState() => _BarGraphState();
}

class _BarGraphState extends State<BarGraph> {

  late List<int> divValues;
  @override
  void initState() {
    super.initState();
    initAxisRange();
  }

  @override
  Widget build(BuildContext context) {
    initAxisRange();
    return BarChart(
      BarChartData(
      backgroundColor: Colors.transparent,
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(
        show: false
      ),
      barGroups: _barGroups(),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: _bottomTitles),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: _leftTitles)
      ),
      barTouchData: _barTouchData,
      ),
      swapAnimationCurve: Curves.decelerate,
      swapAnimationDuration: const Duration(milliseconds: 350),
    );
  }

  List<BarChartGroupData> _barGroups() {
    print(widget.barData.bars.length);
    List<BarChartGroupData> b = widget.barData.bars.map((bar) => BarChartGroupData(x: bar.x, barRods: [BarChartRodData(toY: bar.y, gradient: LinearGradient(
        colors: [darkGreen, darkGreen, lightModeGreen, mainGreen],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter
    ))])).toList();
    print(b.length);
    return b;
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) => Column(
      children: [
        const SizedBox(height: 7),
        Text(
          widget.barData.xLabels[value.toInt()],
          style: TextStyle(color: mainGrey, fontSize: 7, fontWeight: FontWeight.bold),
        ),
      ],
    )
  );

  SideTitles get _leftTitles => SideTitles(
    showTitles: true,
    reservedSize: 30,
    interval: (divValues[1] - divValues[0]).toDouble(),
    getTitlesWidget: (value, meta) {
      int textValue;
      if (value == divValues[0]) {
        textValue = divValues[0];
      } else if (value == divValues[1]) {
        textValue = divValues[1];
      } else if (value == divValues[2]) {
        textValue = divValues[2];
      }
      else {
        return Container();
      }
      return Center(
        child: Text(
          formatNumberWithSuffix(textValue),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: lightGrey
          ),
        ),
      );
    }
  );

  BarTouchData get _barTouchData => BarTouchData(
    touchTooltipData: BarTouchTooltipData(
      fitInsideVertically: true,
      fitInsideHorizontally: true,
      tooltipBgColor: mainGrey,
      getTooltipItem: (group, groupIndex, rod, rodIndex) {
        String label = widget.barData.xLabels[group.x];
        return BarTooltipItem(
          '$label\n',
          TextStyle(
            fontSize: 14,
            color: mainWhite,
          ),
          children: <TextSpan>[
            TextSpan(
              text: (rod.toY) >= 1000 ? formatNumberWithSuffix((rod.toY).toInt()) : (rod.toY).toInt().toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: mainGreen
              )
            )
          ]
        );
      }
    )
  );

  void initAxisRange() {
    List<double> yValues = widget.barData.parsedData;
    yValues.sort();
    double range = yValues[yValues.length-1];
    double tickRange = range / 3;
    int roundedTickRange = roundUpToNearestMultiple(tickRange);
    int factor = (range ~/ roundedTickRange) ~/ 3;
    print(factor);
    divValues = [roundedTickRange, roundedTickRange*2*factor, roundedTickRange*3*factor];
    // print(roundedTickRange);
    print(divValues);
  }

  int roundUpToNearestMultiple(double number) {
    if (number <= 0) return 0;
    int factor = ( log(number)/ln10 ).floor();
    final List<int> multiples = [for (int i = 1; i <= 25; i++ ) (i * pow(10, factor)).toInt()];
    print(multiples);

    int closestMultiple = 1000;
    for (int i = 0; i < multiples.length; i++) {
      if (number/multiples[i] < 1 && i > 0) {
        closestMultiple = (number/multiples[i]) < (number/multiples[i-1] - 1) ? multiples[i] : multiples[i-1];
        break;
      }
    }

    return closestMultiple;
  }

  String formatNumberWithSuffix(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      return '${(number % 1000 == 0) ? number ~/ 1000 : (number / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }
  }
}
