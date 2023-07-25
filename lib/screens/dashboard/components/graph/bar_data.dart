import 'bar.dart';

class BarData {
  DisplayType displayType;
  Map<String, List<Map<String, dynamic>>> data;
  List<double> parsedData = [];
  List<Bar> bars = [];
  List<String> xLabels = [];

  BarData({required this.displayType ,required this.data}) {
    initialize();
  }

  void initialize() {
    Map<String, double> totals = {};
    if (displayType == DisplayType.weekly) {
      xLabels = [
        'SAT',
        'SUN',
        'MON',
        'TUE',
        'WED',
        'THU',
        'FRI'
      ];
    } else if (displayType == DisplayType.monthly) {
      xLabels = [
        'JAN',
        'FEB',
        'MAR',
        'APR',
        'MAY',
        'JUN',
        'JUL',
        'AUG',
        'SEP',
        'OCT',
        'NOV',
        'DEC',
      ];

      totals = { for (var label in xLabels) label: 0};
      for (String day in data.keys) {
        for (Map<String, dynamic> product in data[day]!) {
          String monthLabel = xLabels[int.parse(day.substring(5, 7)) - 1];
          totals[monthLabel] = totals[monthLabel]! + product['price'];
        }
      }
    }
    List<double> totalsList = totals.values.toList();
    parsedData = totalsList;
    for (int i = 0; i < totalsList.length; i++) {
      bars.add(Bar(x: i, y: totalsList[i]));
    }
  }
}

enum DisplayType {
  weekly,
  monthly,
  range
}