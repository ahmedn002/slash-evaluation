// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:slash_eval/app_colors.dart';

class AnalyticsSelectButton extends StatefulWidget {
  final SelectButtonController selectButtonController;
  final Function() onChange;
  const AnalyticsSelectButton({super.key, required this.selectButtonController, required this.onChange});

  @override
  State<AnalyticsSelectButton> createState() => _AnalyticsSelectButtonState();
}

class _AnalyticsSelectButtonState extends State<AnalyticsSelectButton> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      decoration: BoxDecoration(
        color: darkBlack,
        borderRadius: BorderRadius.circular(5)
      ),

      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            left: _selectedIndex * 70,
            child: Container(
              width: 70,
              height: 35,
              decoration: BoxDecoration(
                color: darkGreen,
                borderRadius: BorderRadius.circular(5)
              ),
            ),
          ),
          Row(
            children: [
              SelectButton('Weekly', 0, () {
                setState(() {
                  _selectedIndex = 0;
                  widget.selectButtonController.value = 0;
                  widget.onChange();
                });
              }),
              SelectButton('Monthly', 0, () {
                setState(() {
                  _selectedIndex = 1;
                  widget.selectButtonController.value = 1;
                  widget.onChange();
                });
              }),
              SelectButton('Range', 0, () {
                setState(() {
                  _selectedIndex = 2;
                  widget.selectButtonController.value = 2;
                  widget.onChange();
                });
              })
            ],
          ),
        ],
      ),
    );
  }
  
  GestureDetector SelectButton(String text, int value, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 70,
        height: 35,
        child: Center(child: ButtonText(text)),
      )
    );
  }
  
  Text ButtonText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: mainWhite
      ),
    );
  }
}

class SelectButtonController {
  int value = 1;
}
