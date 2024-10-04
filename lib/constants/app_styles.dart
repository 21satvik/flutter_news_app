import 'package:flutter/material.dart';

class AppStyles {
  // Colors
  static const Color primaryColor = Color(0xFF0c54be); // Primary color
  static const Color secondaryColor = Color(0xFF303F60); // Secondary color
  static const Color lightColor = Color(0xFFf5f9fd); // Light color
  static const Color greyColor = Color(0xFFced3dc); // Grey color

  // Text Styles
  static TextStyle boldText = const TextStyle(
    color: secondaryColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
  );

  static TextStyle mediumText = const TextStyle(
    color: secondaryColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
  );

  static TextStyle regularText = const TextStyle(
    color: secondaryColor,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.normal,
  );
}
