
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:slash_eval/app_colors.dart';

// ignore: must_be_immutable
class PreviewCard extends StatelessWidget {
  final Image? image;
  final String name;
  final String? price;
  PreviewCard({super.key, this.image, required this.name, this.price});

  double screenWidth = 750;
  double screenHeight = 1334;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(screenWidth*screenHeight/20000),
          width: screenWidth/3,
          height: screenHeight/8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: foregroundBlack,
          ),
          child: Center(
            child: image ?? FlutterLogo(size: screenWidth * screenHeight / 5000),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              name.isNotEmpty ? name : 'Product Name',
            ),
          ],
        ),
        
        RatingBar.builder(
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.orangeAccent,
          ),
          onRatingUpdate: (_) {},
          initialRating: 4.5,
          allowHalfRating: true,
          itemSize: screenWidth * screenHeight / 20000,
        ),
        Text(
          'EGP000.0'
        )
      ],
    );
  }
}
