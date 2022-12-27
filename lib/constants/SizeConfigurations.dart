// ignore_for_file: file_names
import 'package:flutter/material.dart';

class SizeConfig {
  MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

double getPropHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight!;
  // 1020 is the designer's specified layout height
  return (inputHeight / 950.0) * screenHeight;
}

double getPropWidth(double inputHeight) {
  double screenWidth = SizeConfig.screenWidth!;
  // 414 is the designer's specified layout width
  return (inputHeight / 400.0) * screenWidth;
}
