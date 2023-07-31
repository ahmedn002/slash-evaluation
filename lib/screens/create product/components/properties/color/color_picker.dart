import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import '../../../../../app_colors.dart';

// ignore: must_be_immutable
class ColorSelector extends StatefulWidget {
  Color color;
  final Function(Color) onColorSelection;
  ColorSelector({super.key, required this.color, required this.onColorSelection});

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  Color _currentColor = foregroundBlack;

  double screenWidth = 750;
  double screenHeight = 1334;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: foregroundBlack,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) => SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: darkBlack
                      ),
                      child: ColorPicker(
                        pickersEnabled: const {
                          ColorPickerType.primary: false,
                          ColorPickerType.accent: false,
                          ColorPickerType.both: false,
                          ColorPickerType.bw: false,
                          ColorPickerType.custom: false,
                          ColorPickerType.wheel: true,
                        },
                        heading: Column(
                          children: [
                            Text(
                              'Pick Product Color',
                              style: TextStyle(
                                  fontSize: screenHeight/45,
                                  fontWeight: FontWeight.bold,
                                  color: lightGrey
                              ),
                            ),
                            Divider(color: mainGrey, indent: screenWidth/10, endIndent: screenWidth/10)
                          ],
                        ),
                        enableShadesSelection: false,
                        enableTonalPalette: true,
                        tonalSubheading: Column(
                          children: [
                            Text(
                              'Shades',
                              style: TextStyle(
                                  fontSize: screenHeight/40,
                                  color: lightGrey
                              ),
                            ),

                            Divider(color: mainGrey, indent: screenWidth/6, endIndent: screenWidth/6)
                          ],
                        ),
                        wheelSquarePadding: screenWidth/30,
                        wheelWidth: screenHeight/100,
                        columnSpacing: screenHeight/50,
                        borderRadius: 4,
                        onColorChanged: (Color value) {
                          setState(() {
                            widget.color = value;
                          });
                        },
                        color: widget.color,
                        width: screenWidth * screenHeight / 10000,
                        height: screenWidth * screenHeight / 10000,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: screenHeight/30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Selected: ',
                            style: TextStyle(
                                fontSize: screenHeight/40,
                                color: lightGrey
                            ),
                          ),

                          Text(
                            ColorTools.nameThatColor(widget.color),
                            style: TextStyle(
                              fontSize: screenHeight/40,
                              fontWeight: FontWeight.bold,
                              color: widget.color
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),
            ),
            
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _currentColor = widget.color);
                      Navigator.of(context).pop();
                      widget.onColorSelection(widget.color);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        fontSize: screenHeight/60,
                        fontWeight: FontWeight.bold,
                        color: darkBlack
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        );
      },

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Color',
            style: TextStyle(
              fontSize: screenHeight/50,
              color: lightGrey
            ),
          ),

          SizedBox(width: screenWidth/20),

          Container(
            width: screenWidth * screenHeight / 11000,
            height: screenWidth * screenHeight / 11000,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: widget.color
            ),
          )
        ],
      ),
    );
  }
}
