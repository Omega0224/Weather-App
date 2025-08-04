import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex (String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class colors {
  static Color backgroundColor1 = HexColor('2E335A');
  static Color backgroundColor2 = HexColor('1C1B33');
  static Color whiteColor = HexColor('FFFFFF');
  static Color greyColor = HexColor('EBEBF5');
  static Color purpleColor = HexColor('48319D');
  static Color blackColor = HexColor('000000');
}