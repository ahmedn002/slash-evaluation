import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:slash_eval/screens/create%20product/components/form_provider.dart';

import '../../../../../app_colors.dart';
import 'color_picker.dart';

class ColorSelectionInput extends StatefulWidget {
  Color selectedColor = mainGreen;
  ColorSelectionInput({super.key});



  @override
  State<ColorSelectionInput> createState() => _ColorSelectionInputState();
}

class _ColorSelectionInputState extends State<ColorSelectionInput> {

  double screenWidth = 750;
  double screenHeight = 1334;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        final provider = Provider.of<FormProvider>(context, listen: false);
        provider.selectedColors.add(widget);
        print(provider.selectedColors);
        provider.notify();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    print('SS: ${widget.selectedColor}');

    return Consumer<FormProvider>(
      builder: (context, formProviderValue, child) => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth/25, vertical: screenHeight/90),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: foregroundBlack
            ),
            child: ColorSelector(color: widget.selectedColor, onColorSelection: (color) {
              setState(() {
                widget.selectedColor = color;
                print('ZZZ: $color, ${widget.selectedColor}');
                // print(widget == provider.selectedColors[0]);
                // print(provider.selectedColors[0].selectedColor);
                formProviderValue.notify();
              });
            })
          )
        ],
      )
    );
  }
}
