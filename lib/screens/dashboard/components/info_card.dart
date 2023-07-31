import 'package:flutter/material.dart';

import '../../../app_colors.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const InfoCard({super.key, required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double screenWidth = size.width;
    final double screenHeight = size.height;

    final double padding = screenWidth*screenHeight/50000;

    return Container(
      width: screenWidth/2.4,
      height: screenHeight/7,
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
                  value,
                  style: TextStyle(
                    fontSize: screenHeight/35,
                    fontWeight: FontWeight.w300,
                    color: mainWhite
                  ),
                ),

                CircleAvatar(
                  backgroundColor: darkBlack,
                  child: Icon(icon, color: mainGreen, size: screenWidth*screenHeight/15000),
                )
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              title,
              style: TextStyle(
                fontSize: screenHeight/32,
                fontWeight: FontWeight.bold,
                color: darkWhite
              ),
            ),
          )
        ],
      ),
    );
  }
}
