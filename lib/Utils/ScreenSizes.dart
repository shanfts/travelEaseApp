import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double heightRef;
  static late double widthRef;
  static late double fontRef;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    // Base values are 375 for width and 820 for height as per your example
    heightRef = screenHeight / 820;
    widthRef = screenWidth / 375;
    fontRef = heightRef; // Use heightRef for font scaling, can be customized
  }
}
