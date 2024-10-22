import 'dart:ui';

import 'package:flutter/material.dart';


class AppColors {
  static  LinearGradient primaryColor1 = LinearGradient(
    colors: [
      Color.fromRGBO(64, 190, 84, 1), // Replace with your desired color values
      Color.fromRGBO(0, 174, 235, 1),  // Replace with your desired color values
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
   );
  static  LinearGradient primaryColor2 = LinearGradient(
    colors: [
      Color(0xff54ba7c).withOpacity(0.1), // Replace with your desired color values
      Color(0xff54ba7c).withOpacity(0.1), // Replace with your desired color values
      // Color(0xff51b89c).withOpacity(0.2),   // Replace with your desired color values
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static  LinearGradient attendanceBg = LinearGradient(
    colors: [
      Color(0xffC3F0DC).withOpacity(0.5), // Replace with your desired color values
      Color(0xffD7E2E7), // Replace with your desired color values
      Color(0xffFFEAB3).withOpacity(0.6), // Replace with your desired color values
      // Color(0xff51b89c).withOpacity(0.2),   // Replace with your desired color values
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  static Color white = Colors.white;
  static Color black = const Color.fromRGBO(51, 51, 51, 1);
  static Color primaryColor = const Color.fromRGBO(51, 51, 51, 1);
  static Color grey = const Color.fromRGBO(133, 139, 143, 1);
  static Color red = const Color.fromRGBO(255, 71, 71, 1);
  static Color lightGrey = const Color.fromRGBO(232, 231, 234, 1);
  static Color dividerColor = const Color.fromRGBO(239, 239, 239, 1);
  static Color blue = const Color.fromRGBO(0, 174, 235, 1);
  static Color secondaryColor = const Color.fromRGBO(0, 193, 197, 1);
  static Color green =  Color.fromRGBO(64, 198, 60, 1);
  static Color darkClrGreen = const Color.fromRGBO(40, 167, 69, 1);
  static Color darkGreen = const Color.fromRGBO(1, 85, 122, 1);
  static Color lightPdfRed = const Color.fromRGBO(250,240,241,255);
  static Color yellow = const Color.fromRGBO(255, 193, 7, 0.15);
  static Color appBarColor = const Color.fromRGBO(64, 190, 84, 1);
  static Color darkBlue = const Color.fromRGBO(0, 18, 83, 1);
  static Color bgbrown = const Color.fromRGBO(220, 53, 69, 0.15);
  static Color lightGreen = Color(0xffdff2e3);
  static Color lightRed = Color(0xfffae1e3);
  static Color lightWhite = Color(0xfff9f9f9);
  static Color snackGreen = Color(0xff2fb97d);
  static Color lightBlue = Color(0xFFeffafe);
  static Color lightOrange = Color(0xFFFFC107);
  static Color transparent = Colors.transparent;

  ///assets
  static Color bgLightBlue = Color(0xFFdcf1f4);
  static Color bgLightYellow = Color(0xFFfdeaae);

}