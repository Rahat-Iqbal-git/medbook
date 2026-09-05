import 'package:dot_matrix_loader/dot_matrix_loader.dart';
import 'package:flutter/material.dart';
import 'package:medbook/core/app_theme/tokens/app_spacing.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DotMatrixLoader(
              size: 72,
              style: DotMatrixStyle(
                activeColor: colors.primary,
                inactiveColor: colors.surfaceContainerHighest,
                dotRadius: 4,
                dotGap: 5,
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('Preparing Medbook', style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Loading your clinical reference…',
              style: textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
