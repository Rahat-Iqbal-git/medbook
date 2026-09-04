import 'package:json_annotation/json_annotation.dart';

part 'clinical_reference_dto.g.dart';

int _strictInt(Object? value) {
  if (value is int) {
    return value;
  }

  throw const FormatException('Expected an integer.');
}

@JsonSerializable(createToJson: false, checked: true)
class ClinicalReferenceDto {
  const ClinicalReferenceDto({
    required this.version,
    required this.diseases,
    required this.antibiotics,
    required this.recommendations,
  });

  factory ClinicalReferenceDto.fromJson(Map<String, dynamic> json) =>
      _$ClinicalReferenceDtoFromJson(json);

  /// Parses a decoded JSON document, including validation of its root shape.
  factory ClinicalReferenceDto.fromDecodedJson(Object? json) {
    if (json is! Map<String, dynamic>) {
      throw const FormatException('Expected response to be a JSON object.');
    }

    return ClinicalReferenceDto.fromJson(json);
  }

  @JsonKey(fromJson: _strictInt)
  final int version;
  final List<DiseaseDto> diseases;
  final List<AntibioticDto> antibiotics;
  final List<TreatmentRecommendationDto> recommendations;
}

@JsonSerializable(createToJson: false, checked: true)
class DiseaseDto {
  const DiseaseDto({
    required this.id,
    required this.name,
    required this.category,
    required this.keywords,
  });

  factory DiseaseDto.fromJson(Map<String, dynamic> json) =>
      _$DiseaseDtoFromJson(json);

  @JsonKey(fromJson: _strictInt)
  final int id;
  final String name;
  final String category;
  final List<String> keywords;
}

@JsonSerializable(createToJson: false, checked: true)
class AntibioticDto {
  const AntibioticDto({
    required this.id,
    required this.name,
    required this.genericName,
  });

  factory AntibioticDto.fromJson(Map<String, dynamic> json) =>
      _$AntibioticDtoFromJson(json);

  @JsonKey(fromJson: _strictInt)
  final int id;
  final String name;
  @JsonKey(name: 'generic_name')
  final String genericName;
}

@JsonSerializable(createToJson: false, checked: true)
class TreatmentRecommendationDto {
  const TreatmentRecommendationDto({
    required this.id,
    required this.diseaseId,
    required this.antibioticId,
    required this.type,
    required this.dose,
    required this.frequency,
    required this.duration,
  });

  factory TreatmentRecommendationDto.fromJson(Map<String, dynamic> json) =>
      _$TreatmentRecommendationDtoFromJson(json);

  @JsonKey(fromJson: _strictInt)
  final int id;
  @JsonKey(name: 'disease_id', fromJson: _strictInt)
  final int diseaseId;

  @JsonKey(name: 'antibiotic_id', fromJson: _strictInt)
  final int antibioticId;
  final String type;
  final String dose;
  final String frequency;
  final String duration;
}
