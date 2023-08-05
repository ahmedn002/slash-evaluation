
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

    return Container(
      padding: EdgeInsets.symmetric(vertical: screenWidth*screenHeight/80000, horizontal: screenWidth*screenHeight/50000),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: darkGrey
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: screenWidth*screenHeight/20000, horizontal: screenWidth*screenHeight/35000),
            width: screenWidth/3,
            height: screenHeight/8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foregroundBlack,
            ),
            child: Center(
              child: image ?? Text('/.', style: TextStyle(fontSize: screenHeight/15),),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    'EGP000.0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.cartShopping, color: mainGreen))
            ],
          )
        ],
      ),
    );
  }
}
