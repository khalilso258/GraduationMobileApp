import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late Orientation orientation;

  static double figmaWidth = 429;
  static double figmaHeight = 923;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  static double scaleWidth(double width) {
    return (width / figmaWidth) * screenWidth;
  }

  static double scaleHeight(double height) {
    return (height / figmaHeight) * screenHeight;
  }
}
