import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../app_colors.dart';

// ignore: must_be_immutable
class ImageSelector extends StatefulWidget {
  Function(File) onImageSelection;
  ImageSelector({super.key, required this.onImageSelection});

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  File? _selectedImage;

  double screenWidth = 750;
  double screenHeight = 1334;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return GestureDetector(
      onTap: () async {
        XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          _selectedImage = File(image!.path);

        });
        print('Calling from selector');
        widget.onImageSelection(_selectedImage!);
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth * screenHeight / 20000),
        width: screenWidth * screenHeight / 3000,
        height: screenWidth * screenHeight / 3000,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: foregroundBlack,
        ),
        child: _selectedImage == null ? Center(
            child: Opacity(opacity: 0.7, child: Image.asset('assets/add-image.png', width: screenWidth * screenHeight / 7000))
        ) : Image.file(_selectedImage!)
      ),
    );
  }
}
