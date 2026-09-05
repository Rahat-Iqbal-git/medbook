import 'dart:async';

import 'package:dot_matrix_loader/dot_matrix_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medbook/app/routing/app_routes.dart';
import 'package:medbook/core/app_theme/extensions/medbook_brand_theme.dart';
import 'package:medbook/core/app_theme/tokens/app_spacing.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
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
    final brand = Theme.of(context).extension<MedbookBrandTheme>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medbook',
          style: textTheme.titleLarge?.copyWith(
            color: brand?.brand ?? colors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) => switch (state) {
          HomeLoading() => Center(
            child: _LoadingContent(
              colors: colors,
              textTheme: textTheme,
            ),
          ),
          HomeReady(:final syncOutcome, :final overview) => _ReadyContent(
            syncOutcome: syncOutcome,
            overview: overview,
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
  const _ReadyContent({
    required this.syncOutcome,
    required this.overview,
    required this.textTheme,
  });

  final SyncOutcome syncOutcome;
  final ClinicalReferenceOverview overview;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (syncOutcome == SyncOutcome.usingCachedData)
          const OfflineStatusBanner(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xxxl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  readOnly: true,
                  decoration: const InputDecoration(
                    hintText: 'Search diseases or medicines',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onTap: () => context.push('/search'),
                ),
                const SizedBox(height: AppSpacing.xxl),
                Text('Diseases', style: textTheme.titleLarge),
                const SizedBox(height: AppSpacing.md),
                _DiseaseCards(diseases: overview.diseases),
                const SizedBox(height: AppSpacing.xxl),
                Text('Medicines', style: textTheme.titleLarge),
                const SizedBox(height: AppSpacing.md),
                _MedicineList(medicines: overview.medicines),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DiseaseCards extends StatelessWidget {
  const _DiseaseCards({required this.diseases});

  final List<DiseaseSummary> diseases;

  @override
  Widget build(BuildContext context) {
    if (diseases.isEmpty) {
      return const Text('No diseases are available.');
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < diseases.length; index++) ...[
            Expanded(child: _DiseaseCard(disease: diseases[index])),
            if (index < diseases.length - 1)
              const SizedBox(width: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _DiseaseCard extends StatelessWidget {
  const _DiseaseCard({required this.disease});

  final DiseaseSummary disease;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: colors.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.push(AppRoutes.disease(disease.id)),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.health_and_safety_outlined, color: colors.primary),
              const SizedBox(height: AppSpacing.xl),
              Text(
                disease.name,
                style: textTheme.titleMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(disease.category, style: textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _MedicineList extends StatelessWidget {
  const _MedicineList({required this.medicines});

  final List<MedicineSummary> medicines;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (medicines.isEmpty) {
      return const Text('No medicines are available.');
    }

    return Column(
      children: [
        for (final medicine in medicines) ...[
          Card(
            color: colors.surfaceContainerHighest,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.xs,
              ),
              leading: CircleAvatar(
                backgroundColor: colors.surfaceContainerHigh,
                child: Icon(
                  Icons.medication_outlined,
                  color: colors.onSurface,
                ),
              ),
              title: Text(medicine.name, style: textTheme.titleMedium),
              subtitle: Text(
                medicine.genericName,
                style: textTheme.bodySmall,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(AppRoutes.medicine(medicine.id)),
            ),
          ),
          if (medicine != medicines.last) const SizedBox(height: AppSpacing.sm),
        ],
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
