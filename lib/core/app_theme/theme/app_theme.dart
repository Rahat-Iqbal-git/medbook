import 'package:flutter/material.dart';

import 'package:medbook/core/app_theme/extensions/app_button_theme.dart';
import 'package:medbook/core/app_theme/extensions/app_spacing_theme.dart';
import 'package:medbook/core/app_theme/extensions/medbook_brand_theme.dart';
import 'package:medbook/core/app_theme/tokens/app_radius.dart';
import 'package:medbook/core/app_theme/tokens/app_spacing.dart';
import 'package:medbook/core/app_theme/tokens/app_typography.dart';
import 'package:medbook/core/app_theme/tokens/color_palette.dart';
import 'package:medbook/core/app_theme/tokens/medbook_brand_color.dart';

abstract final class AppTheme {
  const AppTheme._();

  static final ThemeData light = _build(colors: _lightColorScheme);
  static final ThemeData dark = _build(colors: _darkColorScheme);

  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: ColorPalette.primary,
    primaryContainer: ColorPalette.blackElevated,
    onPrimaryContainer: ColorPalette.onDark,
    secondary: ColorPalette.ink,
    onSecondary: ColorPalette.onPrimary,
    surfaceContainerLowest: ColorPalette.canvas,
    surfaceContainerLow: ColorPalette.canvasSofter,
    surfaceContainer: ColorPalette.canvasSoft,
    surfaceContainerHigh: ColorPalette.canvasSoft,
    surfaceContainerHighest: ColorPalette.canvasSoft,
    outline: ColorPalette.hairlineMid,
    outlineVariant: ColorPalette.surfacePressed,
    error: Color(0xFFBA1A1A),
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: ColorPalette.canvas,
    primaryContainer: ColorPalette.blackElevated,
    onPrimaryContainer: ColorPalette.onDark,
    secondary: ColorPalette.canvas,
    surface: ColorPalette.ink,
    surfaceContainerLowest: ColorPalette.ink,
    surfaceContainerLow: ColorPalette.blackElevated,
    surfaceContainer: ColorPalette.blackElevated,
    surfaceContainerHigh: ColorPalette.blackElevated,
    surfaceContainerHighest: ColorPalette.blackElevated,
    outline: ColorPalette.mute,
    outlineVariant: ColorPalette.hairlineMid,
    error: Color(0xFFFFB4AB),
    onError: Color(0xFF690005),
  );

  static ThemeData _build({required ColorScheme colors}) {
    final textTheme = _textTheme(colors);

    return ThemeData(
      useMaterial3: true,
      brightness: colors.brightness,
      colorScheme: colors,
      scaffoldBackgroundColor: colors.surface,
      textTheme: textTheme,
      extensions: [
        const MedbookBrandTheme(
          brand: MedbookBrandColor.brand,
          onBrand: MedbookBrandColor.onBrand,
        ),
        AppSpacingTheme.fallback,
        AppButtonTheme(
          primary: FilledButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
          ),
          secondary: FilledButton.styleFrom(
            backgroundColor: colors.surfaceContainerHighest,
            foregroundColor: colors.onSurface,
          ),
        ),
      ],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: _cardTheme(colors),
      filledButtonTheme: _filledButtonTheme(colors, textTheme),
      outlinedButtonTheme: _outlinedButtonTheme(colors, textTheme),
      textButtonTheme: _textButtonTheme(colors, textTheme),
      inputDecorationTheme: _inputTheme(colors, textTheme),
      dividerTheme: DividerThemeData(
        color: colors.outlineVariant,
        space: 1,
        thickness: 1,
      ),
    );
  }

  static TextTheme _textTheme(ColorScheme colors) {
    TextStyle withColor(TextStyle style) =>
        style.copyWith(color: colors.onSurface);

    return TextTheme(
      displayLarge: withColor(AppTypography.displayLarge),
      displayMedium: withColor(AppTypography.displayMedium),
      displaySmall: withColor(AppTypography.headingLarge),
      headlineLarge: withColor(AppTypography.headingLarge),
      headlineMedium: withColor(AppTypography.headingMedium),
      headlineSmall: withColor(AppTypography.headingSmall),
      titleLarge: withColor(AppTypography.headingSmall),
      titleMedium: withColor(AppTypography.labelLarge),
      titleSmall: withColor(AppTypography.labelMedium),
      bodyLarge: withColor(AppTypography.paragraphLarge),
      bodyMedium: withColor(AppTypography.paragraphMedium),
      bodySmall: withColor(AppTypography.paragraphSmall),
      labelLarge: withColor(AppTypography.labelLarge),
      labelMedium: withColor(AppTypography.labelMedium),
      labelSmall: withColor(AppTypography.labelSmall),
    );
  }

  static CardThemeData _cardTheme(ColorScheme colors) => CardThemeData(
    color: colors.surface,
    elevation: 0,
    margin: EdgeInsets.zero,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.xl),
    ),
  );

  static FilledButtonThemeData _filledButtonTheme(
    ColorScheme colors,
    TextTheme textTheme,
  ) => FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: colors.primary,
      foregroundColor: colors.onPrimary,
      disabledBackgroundColor: colors.surfaceContainerHighest,
      disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
      elevation: 0,
      minimumSize: const Size(0, 52),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.lg)),
      ),
      textStyle: textTheme.labelLarge,
    ),
  );

  static OutlinedButtonThemeData _outlinedButtonTheme(
    ColorScheme colors,
    TextTheme textTheme,
  ) => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: colors.onSurface,
      minimumSize: const Size(0, 44),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      side: BorderSide(color: colors.outlineVariant),
      shape: const StadiumBorder(),
      textStyle: textTheme.labelLarge,
    ),
  );

  static TextButtonThemeData _textButtonTheme(
    ColorScheme colors,
    TextTheme textTheme,
  ) => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: colors.onSurface,
      minimumSize: const Size(0, 44),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      shape: const StadiumBorder(),
      textStyle: textTheme.labelLarge,
    ),
  );

  static InputDecorationTheme _inputTheme(
    ColorScheme colors,
    TextTheme textTheme,
  ) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      borderSide: BorderSide.none,
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      borderSide: BorderSide(color: colors.primary, width: 2),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: colors.surfaceContainerLow,
      contentPadding: const EdgeInsets.all(AppSpacing.lg),
      hintStyle: textTheme.bodyMedium?.copyWith(color: ColorPalette.mute),
      labelStyle: textTheme.labelMedium,
      border: border,
      enabledBorder: border,
      disabledBorder: border,
      focusedBorder: focusedBorder,
      errorBorder: focusedBorder.copyWith(
        borderSide: BorderSide(color: colors.error, width: 2),
      ),
      focusedErrorBorder: focusedBorder.copyWith(
        borderSide: BorderSide(color: colors.error, width: 2),
      ),
    );
  }
}
