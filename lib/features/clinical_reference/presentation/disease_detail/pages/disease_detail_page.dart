import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medbook/app/routing/app_routes.dart';
import 'package:medbook/core/app_theme/tokens/app_spacing.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/presentation/disease_detail/cubit/disease_detail_cubit.dart';

class DiseaseDetailPage extends StatelessWidget {
  const DiseaseDetailPage({
    required this.id,
    required this.clinicalReferenceRepository,
    super.key,
  });

  final int id;
  final ClinicalReferenceRepository clinicalReferenceRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final cubit = DiseaseDetailCubit(clinicalReferenceRepository);
        unawaited(cubit.load(id));
        return cubit;
      },
      child: const _DiseaseDetailView(),
    );
  }
}

class _DiseaseDetailView extends StatelessWidget {
  const _DiseaseDetailView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Disease details')),
      body: BlocBuilder<DiseaseDetailCubit, DiseaseDetailState>(
        builder: (context, state) => switch (state) {
          DiseaseDetailLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          DiseaseDetailFailure(:final failure) => _DetailFailure(
            message: failure.message,
          ),
          DiseaseDetailLoaded(:final details) => _DiseaseDetailsContent(
            details: details,
          ),
        },
      ),
    );
  }
}

class _DiseaseDetailsContent extends StatelessWidget {
  const _DiseaseDetailsContent({required this.details});

  final DiseaseDetails details;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(details.disease.name, style: textTheme.headlineMedium),
        const SizedBox(height: AppSpacing.xs),
        Text(details.disease.category, style: textTheme.bodyLarge),
        if (details.disease.keywords.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: details.disease.keywords
                .map((keyword) => Chip(label: Text(keyword)))
                .toList(growable: false),
          ),
        ],
        const SizedBox(height: AppSpacing.xxl),
        Text('Treatment recommendations', style: textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        if (details.treatments.isEmpty)
          const Text('No treatment recommendations are available.'),
        for (final treatment in details.treatments) ...[
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(AppSpacing.lg),
              leading: const Icon(Icons.medication_outlined),
              title: Text(treatment.medicine.name),
              subtitle: _RecommendationSummary(
                type: treatment.recommendation.type,
                dose: treatment.recommendation.dose,
                frequency: treatment.recommendation.frequency,
                duration: treatment.recommendation.duration,
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(
                AppRoutes.medicine(treatment.medicine.id),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _RecommendationSummary extends StatelessWidget {
  const _RecommendationSummary({
    required this.type,
    required this.dose,
    required this.frequency,
    required this.duration,
  });

  final String type;
  final String dose;
  final String frequency;
  final String duration;

  @override
  Widget build(BuildContext context) => Text(
    '$type · $dose\n$frequency · $duration',
  );
}

class _DetailFailure extends StatelessWidget {
  const _DetailFailure({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Text(message, textAlign: TextAlign.center),
    ),
  );
}
