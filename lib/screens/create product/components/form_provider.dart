import 'package:flutter/cupertino.dart';
import 'package:slash_eval/app_colors.dart';
import 'package:slash_eval/screens/create%20product/components/properties/color/color_selection_input.dart';

class FormProvider with ChangeNotifier {
  List<ColorSelectionInput> selectedColors = [];
  bool isGlobalPrice = true;

  void notify() {
    print('N: ${selectedColors[0].selectedColor}');
    notifyListeners();
  }

  void setGlobalPrice(bool value) {
    isGlobalPrice = value;
    notifyListeners();
  }
}