import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/core/network/dio_failure_mapper.dart';

/// base client for API-specific Dio clients.
abstract class BaseDioClient {
  BaseDioClient(
    this._dio, {
    required String baseUrl,
    bool enableLogging = false,
    DioFailureMapper? failureMapper,
  }) : _failureMapper = failureMapper ?? const DioFailureMapper() {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(seconds: 15)
      ..options.receiveTimeout = const Duration(seconds: 15)
      ..options.responseType = ResponseType.json;

    if (enableLogging) {
      _dio.interceptors.add(LogInterceptor());
    }
  }

  final Dio _dio;
  final DioFailureMapper _failureMapper;

  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _performRequest(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Either<Failure, T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    return _performRequest(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
    );
  }

  Future<Either<Failure, T>> _performRequest<T>(
    Future<Response<T>> Function() request,
  ) async {
    try {
      final response = await request();
      final data = response.data;

      if (data == null) {
        return const Left(ApiFailure(message: 'The server returned no data.'));
      }

      return Right(data);
    } on DioException catch (exception) {
      return Left(_failureMapper.map(exception));
    }
  }
}
