import 'package:flutter/material.dart';
import 'package:slash_eval/app_colors.dart';

class MaterialSelector extends StatefulWidget {
  final List<String> materials;
  const MaterialSelector({super.key, required this.materials});

  @override
  State<MaterialSelector> createState() => _MaterialSelectorState();
}

class _MaterialSelectorState extends State<MaterialSelector> {

  double screenWidth = 750;
  double screenHeight = 1334;
  String _currentlySelected = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Wrap(
      children: widget.materials.map((material) => GestureDetector(
        onTap: () {
          setState(() {
            _currentlySelected = material;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/80),
          margin: EdgeInsets.symmetric(horizontal: screenWidth/90, vertical: screenHeight/150),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: _currentlySelected == material ? mainGreen : darkGrey
          ),
          child: Text(
            material,
            style: TextStyle(
              fontWeight: _currentlySelected == material ? FontWeight.bold : FontWeight.w400,
              color: _currentlySelected == material ? foregroundBlack : mainWhite
            ),
          ),
        ),
      )).toList()
    );
  }
}
