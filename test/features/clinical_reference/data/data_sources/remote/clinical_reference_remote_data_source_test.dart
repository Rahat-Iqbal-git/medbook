import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/core/network/medbook_api_client/medbook_api_client.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';

void main() {
  group('ClinicalReferenceRemoteDataSource', () {
    test('fetches and parses the clinical reference', () async {
      late Uri requestedUri;
      final dataSource = _dataSourceFor(
        _Adapter((options) async {
          requestedUri = options.uri;
          return ResponseBody.fromString(
            _validResponse,
            200,
            headers: _jsonHeaders,
          );
        }),
      );

      final result = await dataSource.fetchClinicalReference();

      result.match(
        (failure) => fail('Expected a successful response, got $failure.'),
        (dto) {
          expect(dto.version, 1);
          expect(dto.diseases.single.name, 'Aster Respiratory Veil');
          expect(dto.antibiotics.single.name, 'Medicine Alpha');
          expect(dto.recommendations.single.antibioticId, 10);
        },
      );
      expect(
        requestedUri,
        Uri.parse('https://example.test/api/v1/clinical-reference.json'),
      );
    });

    test('maps an invalid response shape to ParsingFailure', () async {
      final dataSource = _dataSourceFor(
        _Adapter(
          (_) async => ResponseBody.fromString(
            '{"version":1,"diseases":"invalid"}',
            200,
            headers: _jsonHeaders,
          ),
        ),
      );

      final result = await dataSource.fetchClinicalReference();

      result.match(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (dto) => fail('Expected a parsing failure, got $dto.'),
      );
    });

    test('preserves an HTTP failure from the API client', () async {
      final dataSource = _dataSourceFor(
        _Adapter(
          (_) async => ResponseBody.fromString(
            '{}',
            503,
            headers: _jsonHeaders,
          ),
        ),
      );

      final result = await dataSource.fetchClinicalReference();

      result.match(
        (failure) {
          expect(failure, isA<ApiFailure>());
          expect((failure as ApiFailure).statusCode, 503);
        },
        (dto) => fail('Expected an API failure, got $dto.'),
      );
    });
  });
}

const _jsonHeaders = <String, List<String>>{
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

const _validResponse = '''
{
  "version": 1,
  "diseases": [
    {
      "id": 1,
      "name": "Aster Respiratory Veil",
      "category": "Respiratory",
      "keywords": ["respiratory", "infection", "cough"]
    }
  ],
  "antibiotics": [
    {
      "id": 10,
      "name": "Medicine Alpha",
      "generic_name": "Formula A"
    }
  ],
  "recommendations": [
    {
      "id": 100,
      "disease_id": 1,
      "antibiotic_id": 10,
      "type": "First Line",
      "dose": "500 mg",
      "frequency": "Twice daily",
      "duration": "5 days"
    }
  ]
}
''';

ClinicalReferenceRemoteDataSource _dataSourceFor(HttpClientAdapter adapter) {
  final dio = Dio()..httpClientAdapter = adapter;
  final apiClient = MedbookApiClient(
    dio,
    baseUrl: 'https://example.test/api/v1/',
  );

  return ClinicalReferenceRemoteDataSourceImpl(apiClient);
}

final class _Adapter implements HttpClientAdapter {
  const _Adapter(this._response);

  final Future<ResponseBody> Function(RequestOptions options) _response;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _response(options);
  }

  @override
  void close({bool force = false}) {}
}
