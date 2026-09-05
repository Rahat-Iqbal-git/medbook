import 'package:flutter/material.dart';

class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  const AppButtonTheme({required this.primary, required this.secondary});

  final ButtonStyle primary;
  final ButtonStyle secondary;

  @override
  AppButtonTheme copyWith({ButtonStyle? primary, ButtonStyle? secondary}) =>
      AppButtonTheme(
        primary: primary ?? this.primary,
        secondary: secondary ?? this.secondary,
      );

  @override
  AppButtonTheme lerp(ThemeExtension<AppButtonTheme>? other, double t) {
    if (other is! AppButtonTheme) return this;

    return AppButtonTheme(
      primary: ButtonStyle.lerp(primary, other.primary, t) ?? primary,
      secondary: ButtonStyle.lerp(secondary, other.secondary, t) ?? secondary,
    );
  }
}
