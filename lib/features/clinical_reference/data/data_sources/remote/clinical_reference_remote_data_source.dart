import 'package:fpdart/fpdart.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/core/network/medbook_api_client/medbook_api_client.dart';
import 'package:medbook/features/clinical_reference/data/dtos/dtos.dart';

//
// ignore: one_member_abstracts
abstract interface class ClinicalReferenceRemoteDataSource {
  Future<Either<Failure, ClinicalReferenceDto>> fetchClinicalReference();
}

final class ClinicalReferenceRemoteDataSourceImpl
    implements ClinicalReferenceRemoteDataSource {
  const ClinicalReferenceRemoteDataSourceImpl(this._apiClient);

  static const _clinicalReferencePath = 'clinical-reference.json';

  final MedbookApiClient _apiClient;

  @override
  Future<Either<Failure, ClinicalReferenceDto>> fetchClinicalReference() async {
    final response = await _apiClient.get<Object>(_clinicalReferencePath);

    return response.flatMap((json) {
      try {
        return Right(ClinicalReferenceDto.fromDecodedJson(json));
      } on FormatException {
        return const Left(
          ParsingFailure(
            message: 'The clinical reference response is invalid.',
          ),
        );
      } on CheckedFromJsonException {
        return const Left(
          ParsingFailure(
            message: 'The clinical reference response is invalid.',
          ),
        );
      }
    });
  }
}
