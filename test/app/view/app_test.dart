import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/app/app.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';
import 'package:medbook/features/home/presentation/pages/homepage.dart';
import 'package:medbook/features/search/presentation/pages/search_page.dart';

void main() {
  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(
        const App(clinicalReferenceRepository: _ClinicalReferenceRepository()),
      );
      expect(find.byType(HomePage), findsOneWidget);
      await tester.pump();
      expect(find.text('Aster Condition'), findsOneWidget);
      expect(find.text('Lumen Fever'), findsOneWidget);
      expect(find.text('Medicine Alpha'), findsOneWidget);
      expect(find.text('Medicine Beta'), findsOneWidget);
      expect(find.text('Medicine Gamma'), findsOneWidget);
    });

    testWidgets('shows the offline status banner when cached data is used', (
      tester,
    ) async {
      await tester.pumpWidget(
        const App(
          clinicalReferenceRepository: _ClinicalReferenceRepository(
            SyncOutcome.usingCachedData,
          ),
        ),
      );
      await tester.pump();

      expect(
        find.text('Offline mode - using saved clinical reference data.'),
        findsOneWidget,
      );
    });

    testWidgets('opens search and shows results', (tester) async {
      await tester.pumpWidget(
        const App(clinicalReferenceRepository: _ClinicalReferenceRepository()),
      );
      await tester.pump();

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      expect(find.byType(SearchPage), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'aster');
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();
      expect(find.text('Aster Condition'), findsOneWidget);
    });

    testWidgets('preserves repository ranking across result types', (
      tester,
    ) async {
      await tester.pumpWidget(
        const App(
          clinicalReferenceRepository: _ClinicalReferenceRepository(
            SyncOutcome.updated,
            [
              ClinicalSearchResult(
                id: 10,
                type: ClinicalSearchResultType.medicine,
                title: 'Medicine Alpha',
                subtitle: 'Formula A',
              ),
              ClinicalSearchResult(
                id: 8,
                type: ClinicalSearchResultType.disease,
                title: 'Prism Vision Haze',
                subtitle: 'Ophthalmology',
              ),
            ],
          ),
        ),
      );
      await tester.pump();

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'first line');
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pump();

      final medicinePosition = tester.getTopLeft(find.text('Medicine Alpha'));
      final diseasePosition = tester.getTopLeft(find.text('Prism Vision Haze'));
      expect(medicinePosition.dy, lessThan(diseasePosition.dy));
    });
  });
}

final class _ClinicalReferenceRepository
    implements ClinicalReferenceRepository {
  const _ClinicalReferenceRepository([
    this.synchronizationOutcome = SyncOutcome.updated,
    this.searchResults = const [
      ClinicalSearchResult(
        id: 1,
        type: ClinicalSearchResultType.disease,
        title: 'Aster Condition',
        subtitle: 'Respiratory',
      ),
    ],
  ]);

  final SyncOutcome synchronizationOutcome;
  final List<ClinicalSearchResult> searchResults;

  @override
  Future<Either<Failure, ClinicalReferenceOverview>> getOverview() async =>
      const Right(_overview);

  @override
  Future<Either<Failure, DiseaseDetails>> getDiseaseDetails({
    required int id,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, MedicineDetails>> getMedicineDetails({
    required int id,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, List<ClinicalSearchResult>>> search({
    required String query,
  }) async => Right(searchResults);

  @override
  Future<Either<Failure, SyncOutcome>> synchronize() async =>
      Right(synchronizationOutcome);
}

const _overview = ClinicalReferenceOverview(
  diseases: [
    DiseaseSummary(id: 1, name: 'Aster Condition', category: 'Respiratory'),
    DiseaseSummary(id: 2, name: 'Lumen Fever', category: 'Infectious'),
  ],
  medicines: [
    MedicineSummary(id: 10, name: 'Medicine Alpha', genericName: 'Formula A'),
    MedicineSummary(id: 11, name: 'Medicine Beta', genericName: 'Formula B'),
    MedicineSummary(id: 12, name: 'Medicine Gamma', genericName: 'Formula C'),
  ],
);
