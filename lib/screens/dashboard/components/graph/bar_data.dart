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
      DateTime inputDate = DateTime.now();

      int daysSinceSaturday = (inputDate.weekday + 1) % 7;
      DateTime startDate = inputDate.subtract(Duration(days: daysSinceSaturday));
      DateTime endDate = startDate.add(Duration(days: 6));

      // Create list of dates for the week
      List<DateTime> datesOfWeek = [];
      DateTime date = startDate;
      while (date.isBefore(endDate) || date.isAtSameMomentAs(endDate)) {
        datesOfWeek.add(date);
        date = date.add(Duration(days: 1));
      }

      totals = { for (var label in xLabels) label: 0};
      for (int i = 0; i < datesOfWeek.length; i++) {
        String date = datesOfWeek[i].toString().substring(0, 10);
        if (data.keys.contains(date)) {
          for (Map<String, dynamic> product in data[date]!) {
            totals[xLabels[i]] = totals[xLabels[i]]! + product['price'];
          }
        }
      }
      List<double> totalsList = totals.values.toList();
      parsedData = totalsList;
      bars = [];
      for (int i = 0; i < totalsList.length; i++) {
        bars.add(Bar(x: i, y: totalsList[i]));
      }

    } else if (displayType == DisplayType.monthly || displayType == DisplayType.range) {
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
    bars = [];
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