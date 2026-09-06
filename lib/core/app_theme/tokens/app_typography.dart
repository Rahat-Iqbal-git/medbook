import 'package:flutter/material.dart';

/// Role-based type scale. Widgets should read styles from [Theme.of].
abstract final class AppTypography {
  const AppTypography._();

  static const String displayFontFamily = 'InterDisplay';
  static const String textFontFamily = 'InterText';
  static const List<String> _fontFallback = ['sans-serif'];

  static const TextStyle displayLarge = TextStyle(
    fontFamily: displayFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 52,
    fontWeight: FontWeight.w700,
    height: 64 / 52,
  );
  static const TextStyle displayMedium = TextStyle(
    fontFamily: displayFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 44 / 36,
  );
  static const TextStyle headingLarge = TextStyle(
    fontFamily: displayFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
  );
  static const TextStyle headingMedium = TextStyle(
    fontFamily: displayFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 32 / 24,
  );
  static const TextStyle headingSmall = TextStyle(
    fontFamily: displayFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 28 / 20,
  );
  static const TextStyle labelLarge = TextStyle(
    fontFamily: textFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 20 / 16,
  );
  static const TextStyle labelMedium = TextStyle(
    fontFamily: textFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
  );
  static const TextStyle labelSmall = TextStyle(
    fontFamily: textFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
  );
  static const TextStyle paragraphLarge = TextStyle(
    fontFamily: textFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 28 / 18,
  );
  static const TextStyle paragraphMedium = TextStyle(
    fontFamily: textFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );
  static const TextStyle paragraphSmall = TextStyle(
    fontFamily: textFontFamily,
    fontFamilyFallback: _fontFallback,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );
}
