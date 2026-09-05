// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_reference_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClinicalReferenceDto _$ClinicalReferenceDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ClinicalReferenceDto', json, ($checkedConvert) {
  final val = ClinicalReferenceDto(
    version: $checkedConvert('version', (v) => _strictInt(v)),
    diseases: $checkedConvert(
      'diseases',
      (v) => (v as List<dynamic>)
          .map((e) => DiseaseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    antibiotics: $checkedConvert(
      'antibiotics',
      (v) => (v as List<dynamic>)
          .map((e) => AntibioticDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    recommendations: $checkedConvert(
      'recommendations',
      (v) => (v as List<dynamic>)
          .map(
            (e) =>
                TreatmentRecommendationDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

DiseaseDto _$DiseaseDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DiseaseDto', json, ($checkedConvert) {
      final val = DiseaseDto(
        id: $checkedConvert('id', (v) => _strictInt(v)),
        name: $checkedConvert('name', (v) => v as String),
        category: $checkedConvert('category', (v) => v as String),
        keywords: $checkedConvert(
          'keywords',
          (v) => (v as List<dynamic>).map((e) => e as String).toList(),
        ),
      );
      return val;
    });

AntibioticDto _$AntibioticDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('AntibioticDto', json, ($checkedConvert) {
      final val = AntibioticDto(
        id: $checkedConvert('id', (v) => _strictInt(v)),
        name: $checkedConvert('name', (v) => v as String),
        genericName: $checkedConvert('generic_name', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'genericName': 'generic_name'});

TreatmentRecommendationDto _$TreatmentRecommendationDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  'TreatmentRecommendationDto',
  json,
  ($checkedConvert) {
    final val = TreatmentRecommendationDto(
      id: $checkedConvert('id', (v) => _strictInt(v)),
      diseaseId: $checkedConvert('disease_id', (v) => _strictInt(v)),
      antibioticId: $checkedConvert('antibiotic_id', (v) => _strictInt(v)),
      type: $checkedConvert('type', (v) => v as String),
      dose: $checkedConvert('dose', (v) => v as String),
      frequency: $checkedConvert('frequency', (v) => v as String),
      duration: $checkedConvert('duration', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {
    'diseaseId': 'disease_id',
    'antibioticId': 'antibiotic_id',
  },
);
