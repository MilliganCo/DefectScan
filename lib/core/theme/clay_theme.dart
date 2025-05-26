import 'package:flutter/material.dart';

class ClayTheme {
  static const Color baseColor = Color(0xFFF0F0F0);
  
  static final customContainerColor = baseColor;
  static final customSpread = 2.0;
  static final customDepth = 40;
  static final customBorderRadius = 15.0;

  static final double clayButtonSpread = 1.0;
  static final int clayButtonDepth = 20;
  static final double clayButtonRadius = 10.0;

  // Цвета текста для дефектов
  static const Color defectErrorColor = Color(0xFFB71C1C); 
  static const Color defectSizeColor = Color(0xFF1B5E20); 
  static const Color defectColorVariantColor = Color(0xFF1A237E); 
  static const Color defectOtherColor = Color.fromARGB(255, 93, 69, 133); 
  static const Color defectOkColor = Color.fromARGB(255, 48, 48, 48); 

  static ThemeData get themeData => ThemeData(
    scaffoldBackgroundColor: baseColor,
    colorScheme: ColorScheme.light(
      primary: baseColor,
      secondary: baseColor.withOpacity(0.9),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: baseColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(clayButtonRadius),
        ),
      ),
    ),
  );
}
