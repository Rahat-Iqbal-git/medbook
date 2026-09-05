import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/data/dtos/dtos.dart';
import 'package:medbook/features/clinical_reference/data/mappers/clinical_reference_mapper.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';

void main() {
  const mapper = ClinicalReferenceMapper();

  group('ClinicalReferenceMapper', () {
    test('maps a valid DTO into domain entities', () {
      mapper.map(_validDto()).match(
        (failure) => fail('Expected valid data, got ${failure.message}.'),
        (dataset) {
          final disease = dataset.diseases.single;
          final medicine = dataset.medicines.single;
          final recommendation = dataset.recommendations.single;

          expect(dataset.version, 1);
          expect(disease.name, 'Aster Respiratory Veil');
          expect(medicine.genericName, 'Formula A');
          expect(recommendation.diseaseId, 1);
          expect(recommendation.medicineId, 10);
        },
      );
    });

    test('rejects a non-positive dataset version', () {
      final result = mapper.map(_validDto(version: 0));

      _expectValidationFailure(
        result,
        'The dataset version must be positive.',
      );
    });

    test('rejects an empty dataset section', () {
      final result = mapper.map(_validDto(diseases: const []));

      _expectValidationFailure(
        result,
        'The dataset must include at least one disease.',
      );
    });

    test('rejects non-positive entity IDs', () {
      final result = mapper.map(
        _validDto(
          medicines: const [
            AntibioticDto(id: 0, name: 'Medicine Alpha', genericName: 'A'),
          ],
        ),
      );

      _expectValidationFailure(result, 'Medicine ID 0 must be positive.');
    });

    test('rejects duplicate entity IDs', () {
      final result = mapper.map(
        _validDto(
          diseases: const [
            DiseaseDto(
              id: 1,
              name: 'Aster Respiratory Veil',
              category: 'Respiratory',
              keywords: ['cough'],
            ),
            DiseaseDto(
              id: 1,
              name: 'Aster Skin Veil',
              category: 'Skin',
              keywords: ['rash'],
            ),
          ],
        ),
      );

      _expectValidationFailure(result, 'Disease ID 1 is duplicated.');
    });

    test('rejects blank and normalized duplicate keywords', () {
      final blankResult = mapper.map(
        _validDto(
          diseases: const [
            DiseaseDto(
              id: 1,
              name: 'Aster Respiratory Veil',
              category: 'Respiratory',
              keywords: ['  '],
            ),
          ],
        ),
      );
      final duplicateResult = mapper.map(
        _validDto(
          diseases: const [
            DiseaseDto(
              id: 1,
              name: 'Aster Respiratory Veil',
              category: 'Respiratory',
              keywords: ['Cough', ' cough '],
            ),
          ],
        ),
      );

      _expectValidationFailure(blankResult, 'Disease 1 has a blank keyword.');
      _expectValidationFailure(
        duplicateResult,
        'Disease 1 has a duplicated keyword.',
      );
    });

    test('rejects recommendations with unknown relationships', () {
      final unknownDiseaseResult = mapper.map(
        _validDto(
          recommendations: const [
            TreatmentRecommendationDto(
              id: 100,
              diseaseId: 999,
              antibioticId: 10,
              type: 'First Line',
              dose: '500 mg',
              frequency: 'Twice daily',
              duration: '5 days',
            ),
          ],
        ),
      );
      final unknownMedicineResult = mapper.map(
        _validDto(
          recommendations: const [
            TreatmentRecommendationDto(
              id: 100,
              diseaseId: 1,
              antibioticId: 999,
              type: 'First Line',
              dose: '500 mg',
              frequency: 'Twice daily',
              duration: '5 days',
            ),
          ],
        ),
      );

      _expectValidationFailure(
        unknownDiseaseResult,
        'Recommendation 100 references an unknown disease.',
      );
      _expectValidationFailure(
        unknownMedicineResult,
        'Recommendation 100 references an unknown medicine.',
      );
    });

    test('rejects blank required text', () {
      final result = mapper.map(
        _validDto(
          recommendations: const [
            TreatmentRecommendationDto(
              id: 100,
              diseaseId: 1,
              antibioticId: 10,
              type: 'First Line',
              dose: ' ',
              frequency: 'Twice daily',
              duration: '5 days',
            ),
          ],
        ),
      );

      _expectValidationFailure(
        result,
        'Recommendation 100 has blank details.',
      );
    });
  });
}

void _expectValidationFailure(
  Either<ValidationFailure, ClinicalReferenceDataset> result,
  String expectedMessage,
) {
  result.match(
    (failure) => expect(failure.message, expectedMessage),
    (dataset) => fail('Expected validation to fail, got $dataset.'),
  );
}

ClinicalReferenceDto _validDto({
  int version = 1,
  List<DiseaseDto>? diseases,
  List<AntibioticDto>? medicines,
  List<TreatmentRecommendationDto>? recommendations,
}) {
  return ClinicalReferenceDto(
    version: version,
    diseases:
        diseases ??
        const [
          DiseaseDto(
            id: 1,
            name: 'Aster Respiratory Veil',
            category: 'Respiratory',
            keywords: ['respiratory', 'cough'],
          ),
        ],
    antibiotics:
        medicines ??
        const [
          AntibioticDto(
            id: 10,
            name: 'Medicine Alpha',
            genericName: 'Formula A',
          ),
        ],
    recommendations:
        recommendations ??
        const [
          TreatmentRecommendationDto(
            id: 100,
            diseaseId: 1,
            antibioticId: 10,
            type: 'First Line',
            dose: '500 mg',
            frequency: 'Twice daily',
            duration: '5 days',
          ),
        ],
  );
}
