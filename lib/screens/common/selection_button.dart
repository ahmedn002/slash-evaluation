// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../../app_colors.dart';

class SelectionButton extends StatefulWidget {
  final SelectionButtonController selectButtonController;
  final List<String> options;
  final double buttonWidth;
  final double buttonHeight;
  final Function(String) onChange;
  const SelectionButton({super.key, required this.selectButtonController, required this.options, required this.buttonWidth, required this.buttonHeight, required this.onChange});

  @override
  State<SelectionButton> createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  int _selectedIndex = 0;

  double screenWidth = 750;
  double screenHeight = 1334;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Container(
      width: widget.buttonWidth * widget.options.length,
      decoration: BoxDecoration(
        color: foregroundBlack,
        borderRadius: BorderRadius.circular(5)
      ),

      child: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOutExpo,
            left: _selectedIndex * widget.buttonWidth,
            child: Container(
              width: widget.buttonWidth,
              height: widget.buttonHeight,
              decoration: BoxDecoration(
                  color: darkGreen,
                  borderRadius: BorderRadius.circular(5)
              ),
            ),
          ),
          Row(
            children: widget.options.map((option) => SelectButton(
              option,
              () {
                setState(() {
                  int index = widget.options.indexOf(option);
                  _selectedIndex = index;
                  widget.selectButtonController.value = option;
                  widget.onChange(option);
                });
              }
            )).toList()
          ),
        ],
      ),
    );
  }

  GestureDetector SelectButton(String text, Function() onPressed) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: widget.buttonWidth,
          height: widget.buttonHeight,
          child: Center(child: ButtonText(text)),
        )
    );
  }

  Text ButtonText(String text) {
    return Text(
      text,
      style: TextStyle(
          fontSize: (widget.buttonHeight/5) * (widget.buttonWidth/65),
          color: mainWhite
      ),
    );
  }
}

class SelectionButtonController {
  String value = 'none';
}