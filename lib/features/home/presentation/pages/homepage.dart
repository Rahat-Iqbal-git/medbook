import 'dart:async';

import 'package:dot_matrix_loader/dot_matrix_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medbook/core/app_theme/tokens/app_spacing.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';
import 'package:medbook/features/home/presentation/cubit/home_cubit.dart';
import 'package:medbook/features/home/presentation/widgets/offline_status_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.clinicalReferenceRepository, super.key});

  final ClinicalReferenceRepository clinicalReferenceRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = HomeCubit(clinicalReferenceRepository);
        unawaited(cubit.synchronize());
        return cubit;
      },
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => switch (state) {
          HomeLoading() => Center(
            child: _LoadingContent(
              colors: colors,
              textTheme: textTheme,
            ),
          ),
          HomeReady(:final syncOutcome) => _ReadyContent(
            syncOutcome: syncOutcome,
            textTheme: textTheme,
          ),
          HomeFailure(:final failure) => Center(
            child: _FailureContent(
              message: failure.message,
              textTheme: textTheme,
              onRetry: context.read<HomeCubit>().synchronize,
            ),
          ),
        },
      ),
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent({required this.colors, required this.textTheme});

  final ColorScheme colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DotMatrixLoader(
          size: 102,
          style: DotMatrixStyle(
            activeColor: colors.primary,
            inactiveColor: colors.surfaceContainerHighest,
            dotRadius: 4,
            dotGap: 5,
          ),
        ),
        const SizedBox(height: AppSpacing.xxxl),
        Text('Preparing Medbook', style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Loading your clinical reference…',
          style: textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _ReadyContent extends StatelessWidget {
  const _ReadyContent({required this.syncOutcome, required this.textTheme});

  final SyncOutcome syncOutcome;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (syncOutcome == SyncOutcome.usingCachedData)
          const OfflineStatusBanner(),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: Text(
                'Clinical reference is ready.',
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FailureContent extends StatelessWidget {
  const _FailureContent({
    required this.message,
    required this.textTheme,
    required this.onRetry,
  });

  final String message;
  final TextTheme textTheme;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Unable to prepare Medbook', style: textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xl),
          FilledButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
