import 'package:flutter/material.dart';

double screenHeight(BuildContext context, {double height}) {
  return MediaQuery.of(context).size.height / height;
}

double screenWidth(BuildContext context, {double width}) {
  return MediaQuery.of(context).size.width / width;
}

class AppConstants {
  static List<Color> colors = [
    Color(0xffFFFFFF), //0
    Color(0xff000000),
    Color(0xff0C8722),
    Color(0xff2D82FE),
    Color(0xFF2FED51),
    Color(0xFFFF9E57), //5
    Color(0xFFE4EFFF),
    Color(0xFF2B73DE),
  ];
}
