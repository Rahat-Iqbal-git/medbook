import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/app/routing/app_router.dart';
import 'package:medbook/app/routing/app_routes.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';
import 'package:medbook/features/clinical_reference/presentation/disease_detail/pages/disease_detail_page.dart';

void main() {
  group('DiseaseDetailPage', () {
    testWidgets('shows loading then the complete disease details', (
      tester,
    ) async {
      final result = Completer<Either<Failure, DiseaseDetails>>();
      final repository = _ClinicalReferenceRepository(
        loadDisease: (_) => result.future,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DiseaseDetailPage(
            id: 1,
            clinicalReferenceRepository: repository,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      result.complete(Right(_details));
      await tester.pumpAndSettle();

      expect(find.text('Aster Respiratory Veil'), findsOneWidget);
      expect(find.text('Respiratory'), findsOneWidget);
      expect(find.widgetWithText(Chip, 'cough'), findsOneWidget);
      expect(find.text('Medicine Alpha'), findsOneWidget);
      expect(
        find.text('First Line · 500 mg\nTwice daily · 5 days'),
        findsOneWidget,
      );
    });

    testWidgets('shows an empty treatment message', (tester) async {
      final repository = _ClinicalReferenceRepository(
        loadDisease: (_) async => Right(_detailsWithoutTreatments),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DiseaseDetailPage(
            id: 1,
            clinicalReferenceRepository: repository,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.text('No treatment recommendations are available.'),
        findsOneWidget,
      );
      expect(find.byType(Chip), findsNothing);
    });

    testWidgets('shows a repository failure', (tester) async {
      final repository = _ClinicalReferenceRepository(
        loadDisease: (_) async => const Left(
          NotFoundFailure(message: 'Disease not found.'),
        ),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: DiseaseDetailPage(
            id: 404,
            clinicalReferenceRepository: repository,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Disease not found.'), findsOneWidget);
    });

    testWidgets('opens a valid disease route', (tester) async {
      final repository = _ClinicalReferenceRepository(
        loadDisease: (_) async => Right(_details),
      );
      final router = createAppRouter(
        clinicalReferenceRepository: repository,
      );
      addTearDown(router.dispose);
      router.go(AppRoutes.disease(1));

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      expect(find.byType(DiseaseDetailPage), findsOneWidget);
      expect(find.text('Aster Respiratory Veil'), findsOneWidget);
    });

    testWidgets('opens the medicine linked from a treatment', (tester) async {
      final repository = _ClinicalReferenceRepository(
        loadDisease: (_) async => Right(_details),
        loadMedicine: (_) async => const Left(
          NotFoundFailure(message: 'Medicine not found.'),
        ),
      );
      final router = createAppRouter(
        clinicalReferenceRepository: repository,
      );
      addTearDown(router.dispose);
      router.go(AppRoutes.disease(1));

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Medicine Alpha'));
      await tester.pumpAndSettle();

      expect(find.text('Medicine details'), findsOneWidget);
      expect(find.text('Medicine not found.'), findsOneWidget);
    });

    testWidgets('rejects an invalid disease route', (tester) async {
      final repository = _ClinicalReferenceRepository(
        loadDisease: (_) async => Right(_details),
      );
      final router = createAppRouter(
        clinicalReferenceRepository: repository,
      );
      addTearDown(router.dispose);
      router.go('/diseases/not-a-number');

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));
      await tester.pumpAndSettle();

      expect(
        find.text('This clinical reference could not be opened.'),
        findsOneWidget,
      );
    });
  });
}

final class _ClinicalReferenceRepository
    implements ClinicalReferenceRepository {
  const _ClinicalReferenceRepository({
    required this.loadDisease,
    this.loadMedicine,
  });

  final Future<Either<Failure, DiseaseDetails>> Function(int id) loadDisease;
  final Future<Either<Failure, MedicineDetails>> Function(int id)? loadMedicine;

  @override
  Future<Either<Failure, DiseaseDetails>> getDiseaseDetails({
    required int id,
  }) => loadDisease(id);

  @override
  Future<Either<Failure, ClinicalReferenceOverview>> getOverview() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, MedicineDetails>> getMedicineDetails({
    required int id,
  }) => loadMedicine!(id);

  @override
  Future<Either<Failure, List<ClinicalSearchResult>>> search({
    required String query,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, SyncOutcome>> synchronize() =>
      throw UnimplementedError();
}

final _details = DiseaseDetails(
  disease: const Disease(
    id: 1,
    name: 'Aster Respiratory Veil',
    category: 'Respiratory',
    keywords: ['cough'],
  ),
  treatments: const [
    DiseaseTreatment(
      recommendation: TreatmentRecommendation(
        id: 100,
        diseaseId: 1,
        medicineId: 10,
        type: 'First Line',
        dose: '500 mg',
        frequency: 'Twice daily',
        duration: '5 days',
      ),
      medicine: Medicine(
        id: 10,
        name: 'Medicine Alpha',
        genericName: 'Formula A',
      ),
    ),
  ],
);

final _detailsWithoutTreatments = DiseaseDetails(
  disease: const Disease(
    id: 1,
    name: 'Aster Respiratory Veil',
    category: 'Respiratory',
    keywords: [],
  ),
  treatments: const [],
);
