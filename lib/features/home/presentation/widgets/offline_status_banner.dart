import 'package:flutter/material.dart';
import 'package:medbook/core/app_theme/extensions/medbook_brand_theme.dart';
import 'package:medbook/core/app_theme/tokens/app_radius.dart';
import 'package:medbook/core/app_theme/tokens/app_spacing.dart';

class OfflineStatusBanner extends StatelessWidget {
  const OfflineStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final brand = Theme.of(context).extension<MedbookBrandTheme>();
    final backgroundColor = brand?.brand ?? colors.primary;
    final foregroundColor = brand?.onBrand ?? colors.onPrimary;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Icon(Icons.cloud_off_outlined, color: foregroundColor),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    'Offline mode - using saved clinical reference data.',
                    style: textTheme.labelMedium?.copyWith(
                      color: foregroundColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
