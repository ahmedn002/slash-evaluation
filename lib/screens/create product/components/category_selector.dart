import 'package:flutter/material.dart';
import 'package:slash_eval/app_colors.dart';

class CategorySelector extends StatefulWidget {
  final CategorySelectorController categorySelectorController;
  final Map<String, String> categories;
  const CategorySelector({super.key, required this.categorySelectorController, required this.categories});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  double screenWidth = 750;
  double screenHeight = 1334;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight/55),
      child: Column(
        children: [
          Text(
            'Select Category',
            style: TextStyle(
              fontSize: screenHeight/40,
              color: lightGrey
            ),
          ),

          Wrap(
            alignment: WrapAlignment.center,
            children: widget.categories.keys.map((category) => GestureDetector(
              onTap: () {
                setState(() {
                  widget.categorySelectorController.value = category;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.all(screenHeight * screenWidth / 17000),
                width: screenHeight * screenWidth / 5500,
                height: screenHeight * screenWidth / 5500,
                decoration: BoxDecoration(
                  border: Border.all(color: widget.categorySelectorController.value == category ? mainGreen : foregroundBlack, width: 1.5),
                  borderRadius: BorderRadius.circular(screenHeight * screenWidth / 28000),
                  color: foregroundBlack
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(widget.categories[category]!, width: screenWidth/12,),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: screenHeight/70 * (category.length > 7 ? 0.9 - 0.05 * (category.length-7) : 1),
                        fontWeight: FontWeight.bold,
                        color: mainGrey
                      ),
                    )
                  ],
                ),
              ),
            )).toList()
          )
        ],
      ),
    );
  }
}

class CategorySelectorController {
  String value = 'none';
}
