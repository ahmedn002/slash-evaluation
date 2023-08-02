// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:slash_eval/app_colors.dart';
import 'package:slash_eval/screens/create%20product/components/category_selector.dart';
import 'package:slash_eval/screens/create%20product/components/preview_card.dart';
import 'package:slash_eval/screens/create%20product/components/slash_text_field.dart';

import 'components/properties/color/color_addition_form.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController _productNameInputController = TextEditingController();
  final TextEditingController _productDescriptionInputController = TextEditingController();
  final CategorySelectorController _categorySelectorController = CategorySelectorController();
  final TextEditingController _productPriceInputController = TextEditingController();

  final ScrollController _colorScrollController = ScrollController();

  Image? _productImage;

  List<ColorAdditionForm> _colorAdditionForms = [];
  List<Color> _colorAdditionFormsColors = [];
  int _index = 0;

  final ItemScrollController _pageSelectorScrollController = ItemScrollController();

  final PageController _pageController = PageController();
  final Duration _swipePageAnimationDuration = const Duration(milliseconds: 1500);
  final Duration _pageSelectorAnimationDuration = const Duration(milliseconds: 250);

  final Curve _animationCurve = Curves.easeOutExpo;

  bool _isGlobalPrice = true;

  double screenWidth = 750;
  double screenHeight = 1334;

  String productName = '';

  @override
  void initState() {
    _colorAdditionForms = [
      ColorAdditionForm(
        key: UniqueKey(),
        isPrimary: true,
        hasPrice: !_isGlobalPrice,
        onFormAddition: colorAdditionOnClick,
        onFormDeletion: (_) {},
        onImageSelection: (image) {
          setState(() {
            _productImage = image;
          });
        },
        onColorSelection: (color) {
          setState(() {
            _colorAdditionFormsColors[0] = color;
          });
        }
      )
    ];
    _colorAdditionFormsColors = [mainGreen];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    final double textFieldWidth = screenWidth/1.3;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: mainWhite
          )
        )
      ),
      home: Scaffold(
        backgroundColor: backgroundBlack,
        appBar: AppBar(
          backgroundColor: backgroundBlack,
          title: Text(
            'Create Product',
            style: TextStyle(
              fontSize: screenHeight/30
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight/40),
                margin: EdgeInsets.symmetric(vertical: screenHeight/55),
                width: screenWidth/1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: secondaryDarkBackgroundColor
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PreviewCard(image: _productImage, name: productName)
                      ],
                    ),

                    SlashTextField(controller: _productNameInputController, width: textFieldWidth, horizontallyAlignLabel: false, labelText: 'Name', hintText: 'Product Name', onChange: () {setState((){
                      print(_productNameInputController.value.text);
                      productName = _productNameInputController.text;
                    });}),
                    SlashTextField(controller: _productDescriptionInputController, width: textFieldWidth, horizontallyAlignLabel: false, labelText: 'Description', hintText: 'Product Description', onChange: () {}),

                    FormDivider(screenWidth),

                    CategorySelector(
                      categorySelectorController: _categorySelectorController,
                      categories: const {
                        'Shirt': 'assets/clothing icons/shirt.png',
                        'T-Shirt': 'assets/clothing icons/tshirt.png',
                        'Pants': 'assets/clothing icons/pants.png',
                        'Dress': 'assets/clothing icons/dress.png',
                        'Sneakers': 'assets/clothing icons/sneakers.png'
                      }
                    ),

                    if (_isGlobalPrice)
                    FormDivider(screenWidth),

                    if (_isGlobalPrice)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Global',
                              style: TextStyle(
                                fontSize: screenHeight/80,
                                color: lightGrey
                              ),
                            ),
                            SizedBox(
                              width: screenWidth / 7,
                              height: screenHeight / 25,
                              child: Checkbox(
                                value: _isGlobalPrice,
                                onChanged: (value) {
                                  setState(() {
                                    _isGlobalPrice = value!;
                                  });
                                },
                                checkColor: foregroundBlack,
                                activeColor: mainGreen,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: screenWidth/1.8,
                          child: SlashTextField(controller: _productPriceInputController, width: screenWidth/2.5, horizontallyAlignLabel: true, labelText: 'Price', hintText: 'Product Price', onChange: () {})
                        ),
                        SizedBox(width: screenWidth/30),
                        Text(
                          'EGP',
                          style: TextStyle(
                            fontSize: screenHeight/50,
                            fontWeight: FontWeight.bold,
                            color: mainGrey
                          )
                        )
                      ],
                    ),
                  ],
                ),
              ),

              FormDivider(screenWidth),

              Container(
                margin: EdgeInsets.only(top: screenHeight/60),
                constraints: BoxConstraints(
                  maxWidth: screenWidth/2.05,
                  maxHeight: screenHeight/20
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: darkGrey),
                  borderRadius: BorderRadius.circular(10),
                  color: foregroundBlack,
                ),
                child: ScrollablePositionedList.builder(
                  itemScrollController: _pageSelectorScrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _colorAdditionForms.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _index = index;
                            _pageController.animateToPage(index, duration: _swipePageAnimationDuration, curve: Curves.easeOutExpo);
                          });
                        },
                        child: AnimatedContainer(
                          duration: _pageSelectorAnimationDuration,
                          padding: EdgeInsets.all(3),
                          margin: EdgeInsets.only(left: screenWidth/25, right: _colorAdditionForms.length == index+1 ? screenWidth/25 : 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: index == _index ? mainGrey : foregroundBlack,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: _colorAdditionForms[index].formColor,
                            ),
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: screenHeight * 1.07,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  onPageChanged: (int index) => setState(() {
                    _index = index;
                    _pageSelectorScrollController.scrollTo(index: index, duration: _swipePageAnimationDuration, curve: _animationCurve);
                  }),
                  children: _colorAdditionForms.map((form) => Center(key: form.key, child: form)).toList(),
                )
              ),
              // ..._colorAdditionForms,

            ],
          ),
        ),
      ),
    );
  }

  void colorAdditionOnClick(ColorAdditionForm form) {
    setState(() {
      int index = _colorAdditionForms.indexOf(form)+1;
      final newForm = ColorAdditionForm(
        key: UniqueKey(),
        isPrimary: false,
        hasPrice: !_isGlobalPrice,
        onFormAddition: colorAdditionOnClick,
        onFormDeletion: (form) {
          setState(() {
            index = _colorAdditionForms.indexOf(form);
            _colorAdditionForms.removeAt(index);
            _pageController.animateToPage(index-1, duration: _swipePageAnimationDuration, curve: _animationCurve);
          });
        },
        onImageSelection: (_) {},
        onColorSelection: (color) {
          setState(() {
            _colorAdditionFormsColors[index] = color;
          });
        }
      );
      _colorAdditionForms.insert(index, newForm);
      _colorAdditionFormsColors.insert(index, mainGreen);
      _pageController.animateToPage(index, duration: _swipePageAnimationDuration, curve: _animationCurve);
      _pageSelectorScrollController.scrollTo(index: index, duration: _swipePageAnimationDuration);
    });
  }
}

Divider FormDivider(double screenWidth) {
  return Divider(
    height: 2,
    indent: screenWidth / 6,
    endIndent: screenWidth / 6,
    color: mainGrey,
  );
}


