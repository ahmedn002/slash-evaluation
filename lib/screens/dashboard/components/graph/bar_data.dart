import 'bar.dart';

class BarData {
  List<double> data;
  BarData({required this.data});

  List<Bar> bars = [];

  void initializeBars() {
    bars = data.asMap().map((index, d) => MapEntry(index, Bar(x: index, y: d))).values.toList();
  }
}