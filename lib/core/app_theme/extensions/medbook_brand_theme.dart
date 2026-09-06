import 'package:flutter/material.dart';

@immutable
class MedbookBrandTheme extends ThemeExtension<MedbookBrandTheme> {
  const MedbookBrandTheme({required this.brand, required this.onBrand});

  final Color brand;
  final Color onBrand;

  @override
  MedbookBrandTheme copyWith({Color? brand, Color? onBrand}) =>
      MedbookBrandTheme(
        brand: brand ?? this.brand,
        onBrand: onBrand ?? this.onBrand,
      );

  @override
  MedbookBrandTheme lerp(ThemeExtension<MedbookBrandTheme>? other, double t) {
    if (other is! MedbookBrandTheme) return this;

    return MedbookBrandTheme(
      brand: Color.lerp(brand, other.brand, t)!,
      onBrand: Color.lerp(onBrand, other.onBrand, t)!,
    );
  }
}
