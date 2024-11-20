import 'package:flutter/material.dart';




class TextStyles {
  // Large Text Styles
  static const TextStyle largeBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle largeSemiBold = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle largeRegular = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.normal,
  );

  // Medium Text Styles
  static const TextStyle mediumBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle mediumSemiBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle mediumRegular = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
  );

  // Small Text Styles
  static const TextStyle smallBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle smallSemiBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle smallRegular = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
}

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);

  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderHighlight = Color(0xFF6200EE);

  // Accent Colors
  static const Color accent = Color(0xFFFF5722);
  static const Color accentLight = Color(0xFFFF8A65);
  
  // Success, Warning, Error Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF6200EE);
  static const Color buttonSecondary = Color(0xFF03DAC6);

  // White and Black
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}
