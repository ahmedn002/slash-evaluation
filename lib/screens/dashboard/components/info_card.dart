import 'package:flutter/material.dart';

import '../../../app_colors.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final double value;
  final IconData icon;
  final bool isPrice;

  const InfoCard({super.key, required this.title, required this.value, required this.icon, required this.isPrice});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    final double padding = 10;

    return Container(
      width: screenWidth/2.2,
      height: screenHeight/6,
      decoration: BoxDecoration(
        color: foregroundBlack,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  (isPrice ? '£' : '') +  (value == value.roundToDouble() ? value.toInt().toString() : value.toString()),
                  style: TextStyle(
                    fontSize: screenHeight/30,
                    fontWeight: FontWeight.w300,
                    color: mainWhite
                  ),
                ),

                CircleAvatar(
                  backgroundColor: mainGrey,
                  child: Icon(icon, color: mainGreen, size: screenWidth*screenHeight/12000),
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              title,
              style: TextStyle(
                fontSize: screenHeight/30,
                fontWeight: FontWeight.bold,
                color: lightModeGreen
              ),
            ),
          )
        ],
      ),
    );
  }
}