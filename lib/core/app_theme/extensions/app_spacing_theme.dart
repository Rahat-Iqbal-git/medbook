import 'package:flutter/material.dart';

import 'package:medbook/core/app_theme/tokens/app_spacing.dart';

@immutable
class AppSpacingTheme extends ThemeExtension<AppSpacingTheme> {
  const AppSpacingTheme({
    required this.pageFooterBottom,
    required this.pageFooterFadeHeight,
    required this.pageFooterScrollInset,
  });

  static const fallback = AppSpacingTheme(
    pageFooterBottom: AppSpacing.xl,
    pageFooterFadeHeight: AppSpacing.xxxl + AppSpacing.lg,
    pageFooterScrollInset: AppSpacing.xxxl * 3 + AppSpacing.lg,
  );

  final double pageFooterBottom;
  final double pageFooterFadeHeight;
  final double pageFooterScrollInset;

  static AppSpacingTheme of(BuildContext context) =>
      Theme.of(context).extension<AppSpacingTheme>() ?? fallback;

  @override
  AppSpacingTheme copyWith({
    double? pageFooterBottom,
    double? pageFooterFadeHeight,
    double? pageFooterScrollInset,
  }) => AppSpacingTheme(
    pageFooterBottom: pageFooterBottom ?? this.pageFooterBottom,
    pageFooterFadeHeight: pageFooterFadeHeight ?? this.pageFooterFadeHeight,
    pageFooterScrollInset: pageFooterScrollInset ?? this.pageFooterScrollInset,
  );

  @override
  AppSpacingTheme lerp(ThemeExtension<AppSpacingTheme>? other, double t) {
    if (other is! AppSpacingTheme) return this;

    return AppSpacingTheme(
      pageFooterBottom:
          pageFooterBottom + (other.pageFooterBottom - pageFooterBottom) * t,
      pageFooterFadeHeight:
          pageFooterFadeHeight +
          (other.pageFooterFadeHeight - pageFooterFadeHeight) * t,
      pageFooterScrollInset:
          pageFooterScrollInset +
          (other.pageFooterScrollInset - pageFooterScrollInset) * t,
    );
  }
}
