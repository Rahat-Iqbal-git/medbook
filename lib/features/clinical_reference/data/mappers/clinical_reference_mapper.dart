import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/data/dtos/dtos.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';
import 'package:medbook/features/clinical_reference/domain/search/normalize_search_text.dart';

final class ClinicalReferenceMapper {
  const ClinicalReferenceMapper();

  Either<ValidationFailure, ClinicalReferenceDataset> map(
    ClinicalReferenceDto dto,
  ) {
    final validationFailure = _validate(dto);
    if (validationFailure != null) {
      return Left(validationFailure);
    }

    return Right(
      ClinicalReferenceDataset(
        version: dto.version,
        diseases: dto.diseases.map(_mapDisease).toList(growable: false),
        medicines: dto.antibiotics.map(_mapMedicine).toList(growable: false),
        recommendations: dto.recommendations
            .map(_mapRecommendation)
            .toList(growable: false),
      ),
    );
  }

  ValidationFailure? _validate(ClinicalReferenceDto dto) {
    if (dto.version <= 0) {
      return const ValidationFailure(
        message: 'The dataset version must be positive.',
      );
    }
    if (dto.diseases.isEmpty) {
      return const ValidationFailure(
        message: 'The dataset must include at least one disease.',
      );
    }
    if (dto.antibiotics.isEmpty) {
      return const ValidationFailure(
        message: 'The dataset must include at least one medicine.',
      );
    }
    if (dto.recommendations.isEmpty) {
      return const ValidationFailure(
        message: 'The dataset must include at least one recommendation.',
      );
    }

    final diseaseIds = <int>{};
    for (final disease in dto.diseases) {
      if (disease.id <= 0) {
        return ValidationFailure(
          message: 'Disease ID ${disease.id} must be positive.',
        );
      }
      if (!diseaseIds.add(disease.id)) {
        return ValidationFailure(
          message: 'Disease ID ${disease.id} is duplicated.',
        );
      }
      if (_isBlank(disease.name)) {
        return ValidationFailure(
          message: 'Disease ${disease.id} has a blank name.',
        );
      }
      if (_isBlank(disease.category)) {
        return ValidationFailure(
          message: 'Disease ${disease.id} has a blank category.',
        );
      }
      if (disease.keywords.isEmpty) {
        return ValidationFailure(
          message: 'Disease ${disease.id} must include a keyword.',
        );
      }

      final normalizedKeywords = <String>{};
      for (final keyword in disease.keywords) {
        final normalizedKeyword = normalizeSearchText(keyword);
        if (normalizedKeyword.isEmpty) {
          return ValidationFailure(
            message: 'Disease ${disease.id} has a blank keyword.',
          );
        }
        if (!normalizedKeywords.add(normalizedKeyword)) {
          return ValidationFailure(
            message: 'Disease ${disease.id} has a duplicated keyword.',
          );
        }
      }
    }

    final medicineIds = <int>{};
    for (final medicine in dto.antibiotics) {
      if (medicine.id <= 0) {
        return ValidationFailure(
          message: 'Medicine ID ${medicine.id} must be positive.',
        );
      }
      if (!medicineIds.add(medicine.id)) {
        return ValidationFailure(
          message: 'Medicine ID ${medicine.id} is duplicated.',
        );
      }
      if (_isBlank(medicine.name)) {
        return ValidationFailure(
          message: 'Medicine ${medicine.id} has a blank name.',
        );
      }
      if (_isBlank(medicine.genericName)) {
        return ValidationFailure(
          message: 'Medicine ${medicine.id} has a blank generic name.',
        );
      }
    }

    final recommendationIds = <int>{};
    for (final recommendation in dto.recommendations) {
      if (recommendation.id <= 0) {
        return ValidationFailure(
          message: 'Recommendation ID ${recommendation.id} must be positive.',
        );
      }
      if (!recommendationIds.add(recommendation.id)) {
        return ValidationFailure(
          message: 'Recommendation ID ${recommendation.id} is duplicated.',
        );
      }
      if (!diseaseIds.contains(recommendation.diseaseId)) {
        return ValidationFailure(
          message:
              'Recommendation ${recommendation.id} references an unknown '
              'disease.',
        );
      }
      if (!medicineIds.contains(recommendation.antibioticId)) {
        return ValidationFailure(
          message:
              'Recommendation ${recommendation.id} references an unknown '
              'medicine.',
        );
      }
      if (_isBlank(recommendation.type) ||
          _isBlank(recommendation.dose) ||
          _isBlank(recommendation.frequency) ||
          _isBlank(recommendation.duration)) {
        return ValidationFailure(
          message: 'Recommendation ${recommendation.id} has blank details.',
        );
      }
    }

    return null;
  }

  bool _isBlank(String value) => normalizeSearchText(value).isEmpty;

  Disease _mapDisease(DiseaseDto dto) {
    return Disease(
      id: dto.id,
      name: dto.name,
      category: dto.category,
      keywords: List.unmodifiable(dto.keywords),
    );
  }

  Medicine _mapMedicine(AntibioticDto dto) {
    return Medicine(
      id: dto.id,
      name: dto.name,
      genericName: dto.genericName,
    );
  }

  TreatmentRecommendation _mapRecommendation(
    TreatmentRecommendationDto dto,
  ) {
    return TreatmentRecommendation(
      id: dto.id,
      diseaseId: dto.diseaseId,
      medicineId: dto.antibioticId,
      type: dto.type,
      dose: dto.dose,
      frequency: dto.frequency,
      duration: dto.duration,
    );
  }
}
