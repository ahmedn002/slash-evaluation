import 'dart:math';
import 'package:intl/intl.dart';

class PurchaseData {
  static String _getDateFromDayOfYear(int dayOfYear) {
    DateTime date = DateTime(2023, 1, 1).add(Duration(days: dayOfYear - 1));
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static int _getRandomProductId() {
    Random random = Random();
    return random.nextInt(100) + 1;
  }

  static double _getRandomPrice() {
    Random random = Random();
    return (random.nextDouble() * 90.0 + 10.0).roundToDouble() / 100.0;
  }

  static Map<String, List<Map<String, dynamic>>> getData() {
    Map<String, List<Map<String, dynamic>>> data = {};
    Random random = Random();
    for (int i = 1; i <= 365; i++) {
      String dateKey = _getDateFromDayOfYear(i);
      data[dateKey] = [];
      for (int j = 0; j < random.nextInt(100); j++) {
        data[dateKey]?.add({
          'productId': _getRandomProductId(),
          'price': _getRandomPrice(),
        });
      }
    }
    return data;
  }
}