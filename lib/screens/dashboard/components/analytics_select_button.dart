// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:slash_eval/app_colors.dart';

class AnalyticsSelectButton extends StatefulWidget {
  const AnalyticsSelectButton({super.key});

  @override
  State<AnalyticsSelectButton> createState() => _AnalyticsSelectButtonState();
}

class _AnalyticsSelectButtonState extends State<AnalyticsSelectButton> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      segments: <ButtonSegment<String>>[
        ButtonSegment<String>(
          value: 'Weekly',
          label: ButtonText('Weekly'),
          icon: Container()
        ),
        ButtonSegment<String>(
          value: 'Monthly',
          label: ButtonText('Monthly'),
          icon: Container()
        ),
        ButtonSegment<String>(
          value: 'Monthly',
          label: ButtonText('Range'),
          icon: Container()
        ),
      ],
      selected: const {'Monthly'},
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        backgroundColor: MaterialStateProperty.all(foregroundBlack),
        elevation: MaterialStateProperty.all(0)
      ),
    );
  }

  Text ButtonText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: mainWhite
      ),
    );
  }
}
