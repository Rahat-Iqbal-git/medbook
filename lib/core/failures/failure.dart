sealed class Failure {
  const Failure({required this.message});

  final String message;
}

final class ApiFailure extends Failure {
  const ApiFailure({String? message, this.statusCode})
    : super(message: message ?? 'Network Failure');

  final int? statusCode;
}

final class ConnectionFailure extends Failure {
  const ConnectionFailure({String? message})
    : super(message: message ?? 'Connection Failure');
}

final class ParsingFailure extends Failure {
  const ParsingFailure({String? message})
    : super(message: message ?? 'Parsing Failure');
}

final class ValidationFailure extends Failure {
  const ValidationFailure({required super.message});
}

final class LocalStorageFailure extends Failure {
  const LocalStorageFailure({String? message})
    : super(message: message ?? 'Local Storage Failure');
}
