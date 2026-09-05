import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/app/app.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';
import 'package:medbook/features/home/presentation/pages/homepage.dart';

void main() {
  group('App', () {
    testWidgets('renders HomePage', (tester) async {
      await tester.pumpWidget(
        const App(clinicalReferenceRepository: _ClinicalReferenceRepository()),
      );
      expect(find.byType(HomePage), findsOneWidget);
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
        find.text('Offline mode — using saved clinical reference data.'),
        findsOneWidget,
      );
    });
  });
}

final class _ClinicalReferenceRepository
    implements ClinicalReferenceRepository {
  const _ClinicalReferenceRepository([
    this.synchronizationOutcome = SyncOutcome.updated,
  ]);

  final SyncOutcome synchronizationOutcome;

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
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, SyncOutcome>> synchronize() async =>
      Right(synchronizationOutcome);
}
