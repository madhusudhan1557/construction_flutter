import 'package:flutter/material.dart';

class AppColors {
  static getColor(String value) {
    return Color(int.parse("0xff$value"));
  }

  static Color blue = getColor("262262");
  static Color white = getColor("F5F5F5");
  static Color customWhite = getColor("E5E5E5");
  static Color yellow = getColor("FFC000");
  static Color red = getColor("C5221F");
  static Color grey = getColor("606060");
  static Color green = getColor("34A853");
  static Color orange = getColor("FF9900");
}
