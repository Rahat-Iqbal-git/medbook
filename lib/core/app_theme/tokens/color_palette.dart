import 'package:flutter/material.dart';

abstract final class ColorPalette {
  const ColorPalette._();

  static const Color primary = Color(0xFF000000);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color blackElevated = Color(0xFF282828);

  static const Color canvas = Color(0xFFFFFFFF);
  static const Color canvasSoft = Color(0xFFEFEFEF);
  static const Color canvasSofter = Color(0xFFF3F3F3);
  static const Color surfacePressed = Color(0xFFE2E2E2);

  static const Color ink = Color(0xFF000000);
  static const Color body = Color(0xFF5E5E5E);
  static const Color hairlineMid = Color(0xFF4B4B4B);
  static const Color mute = Color(0xFFAFAFAF);
  static const Color onDark = Color(0xFFFFFFFF);
  static const Color link = Color(0xFF0000EE);
}
