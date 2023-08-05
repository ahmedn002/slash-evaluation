// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:slash_eval/app_colors.dart';
import 'package:slash_eval/screens/common/selection_button.dart';
import 'package:slash_eval/screens/create%20product/components/properties/color/color_picker.dart';
import 'package:slash_eval/screens/create%20product/components/properties/color/color_selection_input.dart';
import 'package:slash_eval/screens/create%20product/components/image_selector.dart';
import 'package:slash_eval/screens/create%20product/components/properties/material/material_selector.dart';
import 'package:slash_eval/screens/create%20product/components/slash_text_field.dart';
import 'package:slash_eval/screens/create%20product/components/properties/create_product.dart';

import '../form_provider.dart';

class VariationAdditionForm extends StatefulWidget {
  final bool isPrimary;
  bool hasPrice;
  final Function(VariationAdditionForm) onFormAddition;
  final Function(VariationAdditionForm) onFormDeletion;
  final Function(Image) onImageSelection;
  final Function(Color) onColorSelection;
  VariationAdditionForm({super.key, required this.isPrimary, required this.hasPrice, required this.onFormDeletion, required this.onFormAddition, required this.onImageSelection, required this.onColorSelection});

  Color formColor = mainGreen;
  @override
  State<VariationAdditionForm> createState() => _VariationAdditionFormState();
}

class _VariationAdditionFormState extends State<VariationAdditionForm> with AutomaticKeepAliveClientMixin {
  Map<String, bool> variationOptions = {
    'color': true,
    'size': false,
    'material': false
  };

  final ColorSelectionInput _colorSelectionInput = ColorSelectionInput(key: UniqueKey());

  final SelectionButtonController _sizingSystemController = SelectionButtonController();
  List<TextEditingController> _sizeQuantityControllers = [];
  Map<SizedBox, SizedBox> _customSizes = {};
  File? _productImage;
  Color _productColor = mainGreen;

  final TextEditingController _colorPriceInputController = TextEditingController();

  double screenWidth = 750;
  double screenHeight = 1334;

  @override
  void initState() {
    _sizingSystemController.value = 'US';
    _productColor = widget.formColor;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      variationOptions['color'] = false;
    });
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _sizeQuantityControllers = [];

    final Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    final double containerWidth = screenWidth/1.1;
    final double colorAdditionButtonRadius = screenWidth * screenHeight / 12000;

    widget.formColor = _productColor;

    return Consumer<FormProvider>(
      builder: (BuildContext context, formProviderValue, Widget? child) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: screenHeight/55),
              width: containerWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: secondaryDarkBackgroundColor
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight / 40),
                    Text(
                      'Add ${widget.isPrimary ? 'Primary' : 'a'} Variation',
                      style: TextStyle(
                        fontSize: screenHeight/40,
                        color: lightGrey
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: screenHeight/50),
                      child: Column(
                        children: [
                          HeadingText('Select up to 3 Images'),
                          ImageSelector(
                            onImageSelection: (imageFile) async {
                              print('Called');
                              _productImage = imageFile;
                              Color generatedColor = await _findProductColor();
                              setState(() {
                                _productColor = generatedColor;
                                _colorSelectionInput.selectedColor = generatedColor;
                                formProviderValue.notify();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    FormDivider(screenWidth),

                    if (variationOptions['color']!)
                    Column(
                      children: [
                        SizedBox(height: screenHeight / 60),
                        HeadingText('Choose Color'),
                        SizedBox(width: screenWidth / 2, child: _colorSelectionInput),
                        SizedBox(height: screenHeight / 60),
                        FormDivider(screenWidth),
                      ],
                    ),



                    if (variationOptions['size']!)
                    SizeOptions(),

                    if (!formProviderValue.isGlobalPrice)
                    PriceInput(
                      screenWidth,
                      screenHeight,
                      formProviderValue.isGlobalPrice,
                      (value) {
                        formProviderValue.setGlobalPrice(value!);
                      },
                      _colorPriceInputController,
                      false
                    ),

                    if(!formProviderValue.isGlobalPrice)
                    FormDivider(screenWidth),

                    if (variationOptions['material']!)
                    Column(
                      children: [
                        SizedBox(height: screenHeight/70),
                        HeadingText('Choose Material'),
                        const MaterialSelector(materials: [
                          'Cotton', 'Leather', 'Denim', 'Silk', 'Wool', 'Polyster', 'Textile', 'Cashmere'
                        ]),
                        SizedBox(height: screenHeight/70),
                        FormDivider(screenWidth)
                      ],
                    ),

                    PopupMenuButton(
                      itemBuilder: (BuildContext context) => variationOptions.keys.map((option) => PopupMenuItem(
                        onTap: () {
                          setState(() {
                            print('pressed');
                            variationOptions[option] = !(variationOptions[option]!);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: !variationOptions[option]! ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option.capitalize,
                            ),

                            if (variationOptions[option]!)
                            SizedBox(width: screenWidth/30),

                            if (variationOptions[option]!)
                            CircleAvatar(
                              radius: screenHeight * screenWidth / 30000,
                              backgroundColor: mainGreen,
                              child: Icon(FontAwesomeIcons.check, size: screenHeight * screenWidth / 25000, color: darkGrey),
                            ),
                          ],
                        ),
                      )).toList(),
                      color: foregroundBlack,
                      position: PopupMenuPosition.under,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: mainGrey, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      surfaceTintColor: mainGreen,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth / 30, vertical: screenHeight / 80),
                        margin: EdgeInsets.symmetric(vertical: screenHeight / 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: darkGrey,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: mainGreen,
                              child: Icon(FontAwesomeIcons.plus, color: darkGrey),
                            ),
                            SizedBox(width: screenWidth/25),
                            Text(
                              'Add Option',
                              style: TextStyle(
                                fontSize: screenHeight / 50,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth/30, vertical: screenHeight/100),
                        margin: EdgeInsets.only(bottom: screenHeight / 80),
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
                            Text('Submit', style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Positioned(
              left: containerWidth - colorAdditionButtonRadius * 1.35 * 1.4,
              child: CircleAvatar(
                radius: colorAdditionButtonRadius * 1.35,
                backgroundColor: background,
                child: CircleAvatar(
                  radius: colorAdditionButtonRadius,
                  backgroundColor: mainGreen,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.plus, size: colorAdditionButtonRadius * 1.1, color: foregroundBlack),
                    onPressed: () {
                      print('Pressing');
                      widget.onFormAddition(widget);
                    },
                  ),
                ),
              )
            ),

            if (!widget.isPrimary)
            Positioned(
              left: containerWidth - colorAdditionButtonRadius * 1.4,
              top: screenHeight/12,
              child: CircleAvatar(
                radius: colorAdditionButtonRadius,
                backgroundColor: background,
                child: CircleAvatar(
                  radius: colorAdditionButtonRadius * 0.7,
                  backgroundColor: darkBlack,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.trash, size: colorAdditionButtonRadius * 0.7, color: mainGreen),
                    onPressed: () {
                      print('Pressing');
                      widget.onFormDeletion(widget);
                    },
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                ),
              )
            )
          ]
        );
      }
    );
  }

  Padding HeadingText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: screenHeight/50),
      child: Text(
        text,
        style: TextStyle(
          fontSize: screenHeight/50,
          color: lightGrey
        ),
      ),
    );
  }

  Column SizeOptions() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight/50),
          child: Column(
            children: [
              HeadingText('Choose Sizing System'),
              SelectionButton(
                  selectButtonController: _sizingSystemController,
                  options: const ['US', 'Euro', 'Custom'],
                  buttonWidth: screenWidth/4,
                  buttonHeight: screenHeight/17,
                  onChange: (value) {
                    setState(() {
                      _customSizes = {};
                      addCustomSizeInput();
                    });
                  }
              ),
            ],
          ),
        ),

        if (_sizingSystemController.value != 'Custom')
          SizedBox(height: screenHeight/30),

        ...<String, List<String>>{
          'US': ['XL', 'L', 'M', 'S', 'XS'],
          'Euro': ['40', '38', '36', '34', '32'],
          'Custom': [],
          'none': []
        }[_sizingSystemController.value]!.map((size) {
          TextEditingController controller = TextEditingController();
          _sizeQuantityControllers.add(controller);
          return Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth/25),
              margin: EdgeInsets.only(bottom: screenHeight/80),
              width: screenWidth/1.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black38
              ),
              child: SlashTextField(isReadOnly: false, controller: controller, width: screenWidth/2.5, horizontallyAlignLabel: true, labelText: size, hintText: '$size Quantity', onChange: (){})
          );
        }).toList(),

        if (_sizingSystemController.value == 'Custom')
        ..._customSizes.keys.map((sizeInput) => Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth/20, vertical: screenHeight/120),
          margin: EdgeInsets.only(bottom: screenHeight/80),
          width: screenWidth/1.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black38
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: screenWidth * screenHeight / 15000,
                backgroundColor: foregroundBlack,
                child: IconButton(
                  icon: Icon(FontAwesomeIcons.trash, size: screenWidth * screenHeight / 19000, color: mainGreen),
                  onPressed: () {
                    setState(() {
                      _customSizes.remove(sizeInput);
                    });
                  },
                ),
              ),
              sizeInput,
              _customSizes[sizeInput]!
            ],
          ),
        )),

        if (_sizingSystemController.value == 'Custom')
        GestureDetector(
          onTap: () {
            if (_customSizes.length != 6) {
              addCustomSizeInput();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth/60, vertical: screenHeight/100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: foregroundBlack,
            ),
            child: SizedBox(
              width: screenWidth/3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: mainGreen,
                    radius: screenWidth * screenHeight / 20000,
                    child: Icon(FontAwesomeIcons.plus, color: foregroundBlack)
                  ),
                  Text(
                    'Add Size',
                    style: TextStyle(
                      fontSize: screenHeight / 60,
                      color: lightGrey
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        if (_sizingSystemController.value == 'Custom')
        SizedBox(height: screenHeight/60),
        
        FormDivider(screenWidth)
      ],
    );
  }

  void addCustomSizeInput() {
    SizedBox sizeInput = SlashTextField.InputField(false, TextEditingController(), screenWidth/5.5, 12, 'Name', (){});
    SizedBox sizeQuantity = SlashTextField.InputField(false, TextEditingController(), screenWidth/3.5, 12, 'Size Quantity', (){});
    setState(() {
      _customSizes[sizeInput] = sizeQuantity;
    });
  }

  Future<Color> _findProductColor() async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      FileImage(_productImage!),
      size: const Size(200, 200)
    );
    return paletteGenerator.dominantColor?.color ?? mainGreen;
  }
}