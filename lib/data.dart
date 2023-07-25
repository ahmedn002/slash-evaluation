import 'dart:math';
import 'package:intl/intl.dart';

class PurchaseData {
  static double price = 0;
  static String _getDateFromDayOfYear(int dayOfYear) {
    DateTime date = DateTime(2023, 1, 1).add(Duration(days: dayOfYear - 1));
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static int _getRandomProductId() {
    Random random = Random();
    return random.nextInt(100) + 1;
  }

  static double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static double _getRandomPrice() {
    Random random = Random();
    double r = roundDouble(random.nextDouble() * 783 + 10.0, 2);
    price += r;
    return r;
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
    print(price);
    return data;
  }
}