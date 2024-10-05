import 'package:flutter/material.dart';

/**
 * AppStyles class that contains predefined colors and text styles 
 * used throughout the application.
 */
class AppStyles {
  static const Color primaryColor = Color(0xFF0c54be);
  static const Color secondaryColor = Color(0xFF303F60);
  static const Color lightColor = Color(0xFFf5f9fd);
  static const Color greyColor = Color(0xFFced3dc);

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
