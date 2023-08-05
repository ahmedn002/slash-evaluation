// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:slash_eval/app_colors.dart';
import 'package:slash_eval/screens/create%20product/components/category_selector.dart';
import 'package:slash_eval/screens/create%20product/components/form_provider.dart';
import 'package:slash_eval/screens/create%20product/components/preview_card.dart';
import 'package:slash_eval/screens/create%20product/components/slash_text_field.dart';

import 'variation_addition_form.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  late FormProvider provider;

  final TextEditingController _productNameInputController = TextEditingController();
  final TextEditingController _productDescriptionInputController = TextEditingController();
  final CategorySelectorController _categorySelectorController = CategorySelectorController();
  final TextEditingController _productPriceInputController = TextEditingController();

  final ScrollController _colorScrollController = ScrollController();

  Image? _productImage;

  List<VariationAdditionForm> _colorAdditionForms = [];
  int _index = 0;

  final ItemScrollController _pageSelectorScrollController = ItemScrollController();

  final PageController _mainPageController = PageController();
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
      VariationAdditionForm(
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
          });
        }
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('BUILDING SCREEN');
    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
    final double textFieldWidth = screenWidth/1.3;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FormProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(
            Theme.of(context).textTheme.apply(
              bodyColor: mainWhite
            )
          )
        ),
        home: Consumer<FormProvider>(
          builder: (context, formProviderValue, child) {
            provider = formProviderValue;
            return Scaffold(
              backgroundColor: backgroundBlack,
              appBar: AppBar(
                backgroundColor: backgroundBlack,
                title: Text(
                  'Create Product',
                  style: TextStyle(
                      fontSize: screenHeight / 30
                  ),
                ),
              ),

              body: PageView(
                controller: _mainPageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: screenHeight / 40),
                      margin: EdgeInsets.symmetric(vertical: screenHeight / 55),
                      width: screenWidth / 1.1,
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

                          SlashTextField(
                              isReadOnly: false,
                              controller: _productNameInputController,
                              width: textFieldWidth,
                              horizontallyAlignLabel: false,
                              labelText: 'Name',
                              hintText: 'Product Name',
                              onChange: () {
                                setState(() {
                                  print(_productNameInputController.value.text);
                                  productName = _productNameInputController.text;
                                });
                              }
                          ),

                          SlashTextField(
                              isReadOnly: false,
                              controller: _productDescriptionInputController,
                              width: textFieldWidth,
                              horizontallyAlignLabel: false,
                              labelText: 'Description',
                              hintText: 'Product Description',
                              onChange: () {}
                          ),

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

                          FormDivider(screenWidth),

                          PriceInput(
                              screenWidth,
                              screenHeight,
                              formProviderValue.isGlobalPrice,
                                  (value) {
                                _productPriceInputController.clear();
                                formProviderValue.setGlobalPrice(value!);
                              },
                              _productPriceInputController,
                              !formProviderValue.isGlobalPrice
                          ),

                          GestureDetector(
                            onTap: () {
                              _mainPageController.animateToPage(1, duration: _swipePageAnimationDuration, curve: _animationCurve);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/100),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: darkGrey
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: mainGreen,
                                    child: Icon(FontAwesomeIcons.check, color: foregroundBlack),
                                  ),
                                  SizedBox(width: screenWidth/25),
                                  Text('Submit')
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: screenHeight / 60),
                          constraints: BoxConstraints(
                              maxWidth: screenWidth / 2.05,
                              maxHeight: screenHeight / 20
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
                            itemCount: formProviderValue.selectedColors.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Center(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _index = index;
                                      _pageController.animateToPage(
                                          index,
                                          duration: _swipePageAnimationDuration,
                                          curve: Curves.easeOutExpo
                                      );
                                    });
                                  },
                                  child: AnimatedContainer(
                                    duration: _pageSelectorAnimationDuration,
                                    padding: EdgeInsets.all(3),
                                    margin: EdgeInsets.only(left: screenWidth / 25, right: formProviderValue.selectedColors.length == index + 1 ? screenWidth / 25 : 0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: index == _index ? mainGrey : foregroundBlack,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: darkGrey),
                                        borderRadius: BorderRadius.circular(4),
                                        color: formProviderValue.selectedColors[index].selectedColor,
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

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight / 1.2,
                              child: PageView(
                                controller: _pageController,
                                onPageChanged: (int index) {
                                  setState(() {
                                    _index = index;
                                    _pageSelectorScrollController.scrollTo(
                                      index: index,
                                      duration: _swipePageAnimationDuration,
                                      curve: _animationCurve
                                    );
                                    print('PP: ${formProviderValue.selectedColors[_index]
                                        .selectedColor}');
                                  });
                                },
                                children: _colorAdditionForms.map((form) {
                                  print('LLL: ${_colorAdditionForms.length}');
                                  form.hasPrice = !_isGlobalPrice;
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      form,
                                    ],
                                  );
                                }).toList()
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  )
                ],
              )
            );
          }
        ),
      ),
    );
  }

  void colorAdditionOnClick(VariationAdditionForm form) {
    setState(() {
      int index = _colorAdditionForms.indexOf(form)+1;
      final newForm = VariationAdditionForm(
        key: UniqueKey(),
        isPrimary: false,
        hasPrice: !_isGlobalPrice,
        onFormAddition: colorAdditionOnClick,
        onFormDeletion: (form) {
          setState(() {
            index = _colorAdditionForms.indexOf(form);
            _colorAdditionForms.removeAt(index);
            provider.selectedColors.removeAt(index);
            _pageController.animateToPage(index-1, duration: _swipePageAnimationDuration, curve: _animationCurve);
          });
        },
        onImageSelection: (_) {},
        onColorSelection: (color) {
          setState(() {
          });
        }
      );
      _colorAdditionForms.insert(index, newForm);
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

Row PriceInput(double screenWidth, double screenHeight, bool isGlobalPrice,void Function(bool?)? onSetGlobalValue, TextEditingController productPriceInputController, bool isReadOnly) {
  return Row(
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
              value: isGlobalPrice,
              onChanged: onSetGlobalValue,
              checkColor: foregroundBlack,
              activeColor: mainGreen,
            ),
          )
        ],
      ),
      AnimatedOpacity(
        opacity: !isReadOnly ? 1 : 0.4,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutExpo,
        child: Row(
          children: [
            SizedBox(
              width: screenWidth/1.8,
              child: SlashTextField(isReadOnly: isReadOnly, controller: productPriceInputController, width: screenWidth/2.5, horizontallyAlignLabel: true, labelText: 'Price', hintText: 'Product Price', onChange: () {})
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
      )
    ],
  );
}