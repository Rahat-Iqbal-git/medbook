import 'package:dio/dio.dart';
import 'package:medbook/core/failures/failure.dart';

final class DioFailureMapper {
  const DioFailureMapper();

  Failure map(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
        return const ConnectionFailure(
          message: 'Unable to connect to the server. Please try again.',
        );
      case DioExceptionType.badResponse:
        return ApiFailure(
          message: _messageForStatusCode(exception.response?.statusCode),
          statusCode: exception.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return const ApiFailure(message: 'The request was cancelled.');
      case DioExceptionType.badCertificate:
        return const ApiFailure(message: 'The server certificate is invalid.');
      case DioExceptionType.unknown:
        if (exception.error is FormatException) {
          return const ParsingFailure(
            message: 'The server returned invalid JSON.',
          );
        }

        return const ApiFailure(
          message: 'An unexpected network error occurred.',
        );
    }
  }

  String _messageForStatusCode(int? statusCode) {
    return switch (statusCode) {
      400 => 'The server could not process the request.',
      401 || 403 => 'The request is not authorized.',
      404 => 'The requested resource was not found.',
      final code? when code >= 500 => 'The server is temporarily unavailable.',
      _ => 'The server returned an unexpected response.',
    };
  }
}
