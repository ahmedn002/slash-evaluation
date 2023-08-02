// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:slash_eval/app_colors.dart';

class SlashTextField extends StatelessWidget {
  final bool isReadOnly;
  final TextEditingController controller;
  final double width;
  final bool horizontallyAlignLabel;
  final String labelText;
  final String hintText;
  final Function() onChange;
  SlashTextField({super.key, required this.isReadOnly, required this.controller, required this.width, required this.horizontallyAlignLabel, required this.labelText, required this.hintText, required this.onChange});

  double screenWidth = 750;
  double screenHeight = 1334;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight/50),
      child: (horizontallyAlignLabel ?
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFieldLabel(),
            InputField(isReadOnly ,controller, width, screenHeight/55, hintText, onChange)
          ],
        ) : Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: (screenWidth - width)/1.8),
                  child: TextFieldLabel(),
                ),
              ],
            ),
            InputField(isReadOnly, controller, width, screenHeight/55, hintText, onChange)
          ],
        )
      )
    );

  }

  static SizedBox InputField(bool isReadOnly ,TextEditingController controller, double textFieldWidth, double fontSize, String hintText, Function() onChange) {
    return SizedBox(
      width: textFieldWidth,
      child: TextField(
        readOnly: isReadOnly,
        controller: controller,
        cursorWidth: 2,
        cursorColor: mainGrey,
        cursorRadius: const Radius.circular(10),
        autofocus: false,
        style: TextStyle(
          fontSize: fontSize,
          color: mainWhite
        ),
        decoration: InputDecoration(
          enabledBorder: TextFieldBorder(),
          focusedBorder: TextFieldBorder(),
          border: TextFieldBorder(),
          filled: true,
          fillColor: foregroundBlack,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: fontSize,
            color: mainGrey
          ),
        ),
        onChanged: (_) {
          print('Changing');
          onChange();},
      ),
    );
  }

  Text TextFieldLabel() {
    return Text(
      labelText,
      style: TextStyle(
        fontSize: horizontallyAlignLabel ? screenHeight / 50 : screenHeight/40,
        color: lightGrey
      ),
    );
  }

  static UnderlineInputBorder TextFieldBorder() {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(color: mainGreen, width: 3)
    );
  }
}
