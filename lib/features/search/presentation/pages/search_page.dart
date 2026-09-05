import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:medbook/app/routing/app_routes.dart';
import 'package:medbook/core/app_theme/tokens/app_spacing.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/search/presentation/cubit/search_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({required this.clinicalReferenceRepository, super.key});

  final ClinicalReferenceRepository clinicalReferenceRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(clinicalReferenceRepository),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.md,
          AppSpacing.lg,
          0,
        ),
        child: Column(
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Search diseases or medicines',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: context.read<SearchCubit>().queryChanged,
            ),
            const SizedBox(height: AppSpacing.lg),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) => switch (state) {
                  SearchIdle() => _Message(
                    'Search diseases, medicines, or treatment details.',
                    style: textTheme.bodyMedium,
                  ),
                  SearchLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  SearchEmpty(:final query) => _Message(
                    'No results for “$query”.',
                    style: textTheme.bodyMedium,
                  ),
                  SearchFailure(:final failure) => _Message(
                    failure.message,
                    style: textTheme.bodyMedium,
                  ),
                  SearchResults(:final results) => _SearchResults(
                    results: results,
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message(this.message, {required this.style});

  final String message;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(message, style: style, textAlign: TextAlign.center),
  );
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({required this.results});

  final List<ClinicalSearchResult> results;

  @override
  Widget build(BuildContext context) {
    final diseases = results
        .where((result) => result.type == ClinicalSearchResultType.disease)
        .toList(growable: false);
    final medicines = results
        .where((result) => result.type == ClinicalSearchResultType.medicine)
        .toList(growable: false);

    return ListView(
      children: [
        if (diseases.isNotEmpty) ...[
          const _ResultSectionTitle('Diseases'),
          ...diseases.map(_SearchResultTile.new),
        ],
        if (medicines.isNotEmpty) ...[
          const _ResultSectionTitle('Medicines'),
          ...medicines.map(_SearchResultTile.new),
        ],
      ],
    );
  }
}

class _ResultSectionTitle extends StatelessWidget {
  const _ResultSectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(
      top: AppSpacing.sm,
      bottom: AppSpacing.xs,
    ),
    child: Text(title, style: Theme.of(context).textTheme.titleLarge),
  );
}

class _SearchResultTile extends StatelessWidget {
  const _SearchResultTile(this.result);

  final ClinicalSearchResult result;

  @override
  Widget build(BuildContext context) {
    final isDisease = result.type == ClinicalSearchResultType.disease;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        isDisease
            ? Icons.health_and_safety_outlined
            : Icons.medication_outlined,
      ),
      title: Text(result.title),
      subtitle: Text(result.subtitle),
      onTap: () => context.push(
        isDisease
            ? AppRoutes.disease(result.id)
            : AppRoutes.medicine(result.id),
      ),
    );
  }
}
