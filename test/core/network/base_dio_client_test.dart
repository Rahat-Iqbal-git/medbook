import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/core/network/base_dio_client/base_dio_client.dart';
import 'package:medbook/core/network/base_dio_client/dio_failure_mapper.dart';

void main() {
  group('BaseDioClient', () {
    test('returns decoded JSON from a successful response', () async {
      final client = _clientFor(
        _Adapter(
          (_) async => ResponseBody.fromString(
            '{"version": 1}',
            200,
            headers: _jsonHeaders,
          ),
        ),
      );

      final result = await client.get<Object>('/reference');

      result.match(
        (failure) => fail('Expected a successful response, got $failure.'),
        (data) => expect(data, equals({'version': 1})),
      );
    });

    test('returns ApiFailure when a successful response has no body', () async {
      final client = _clientFor(
        _Adapter(
          (_) async => ResponseBody.fromString(
            'null',
            200,
            headers: _jsonHeaders,
          ),
        ),
      );

      final result = await client.get<Object>('/reference');

      result.match(
        (failure) {
          expect(failure, isA<ApiFailure>());
          expect(failure.message, 'The server returned no data.');
        },
        (data) => fail('Expected an API failure, got $data.'),
      );
    });

    test('maps a malformed JSON response to ParsingFailure', () async {
      final client = _clientFor(
        _Adapter(
          (_) async => ResponseBody.fromString(
            '{not valid json',
            200,
            headers: _jsonHeaders,
          ),
        ),
      );

      final result = await client.get<Object>('/reference');

      result.match(
        (failure) => expect(failure, isA<ParsingFailure>()),
        (data) => fail('Expected a parsing failure, got $data.'),
      );
    });

    test(
      'maps an unsuccessful response to ApiFailure with its status code',
      () async {
        final client = _clientFor(
          _Adapter(
            (_) async => ResponseBody.fromString(
              '{}',
              503,
              headers: _jsonHeaders,
            ),
          ),
        );

        final result = await client.get<Object>('/reference');

        result.match(
          (failure) {
            expect(failure, isA<ApiFailure>());
            expect((failure as ApiFailure).statusCode, 503);
          },
          (data) => fail('Expected an API failure, got $data.'),
        );
      },
    );
  });

  group('DioFailureMapper', () {
    const mapper = DioFailureMapper();

    test('maps a format exception to ParsingFailure', () {
      final failure = mapper.map(
        DioException(
          requestOptions: RequestOptions(path: '/reference'),
          error: const FormatException('Invalid JSON'),
        ),
      );

      expect(failure, isA<ParsingFailure>());
    });

    test('maps a connection error to ConnectionFailure', () {
      final failure = mapper.map(
        DioException.connectionError(
          requestOptions: RequestOptions(path: '/reference'),
          reason: 'No connection',
        ),
      );

      expect(failure, isA<ConnectionFailure>());
    });
  });

  group('BaseDioClient configuration', () {
    test('does not install logging by default', () {
      final client = _TestDioClient(Dio());

      expect(client.dio.interceptors.whereType<LogInterceptor>(), isEmpty);
    });
  });
}

const _jsonHeaders = <String, List<String>>{
  Headers.contentTypeHeader: [Headers.jsonContentType],
};

_TestDioClient _clientFor(HttpClientAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
    ..httpClientAdapter = adapter;
  return _TestDioClient(dio);
}

final class _TestDioClient extends BaseDioClient {
  _TestDioClient(this.dio) : super(dio, baseUrl: 'https://example.test');

  final Dio dio;
}

final class _Adapter implements HttpClientAdapter {
  _Adapter(this._response);

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
