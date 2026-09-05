import 'package:medbook/core/config/app_environment.dart';

abstract interface class EnvironmentConfig {
  AppEnvironment get environment;
  String get medbookApiBaseUrl;
  bool get enableNetworkLogging;
}

final class EnvironmentFactory {
  const EnvironmentFactory._();

  static EnvironmentConfig create(AppEnvironment environment) {
    return switch (environment) {
      AppEnvironment.development => _DevelopmentConfig(),
      AppEnvironment.staging => _StagingConfig(),
      AppEnvironment.production => _ProductionConfig(),
    };
  }
}

final class _DevelopmentConfig implements EnvironmentConfig {
  @override
  AppEnvironment get environment => AppEnvironment.development;

  @override
  String get medbookApiBaseUrl => _readMedbookApiBaseUrl();

  @override
  bool get enableNetworkLogging => const bool.fromEnvironment(
    'ENABLE_NETWORK_LOGGING',
    defaultValue: true,
  );
}

final class _StagingConfig implements EnvironmentConfig {
  @override
  AppEnvironment get environment => AppEnvironment.staging;

  @override
  String get medbookApiBaseUrl => _readMedbookApiBaseUrl();

  @override
  bool get enableNetworkLogging => const bool.fromEnvironment(
    'ENABLE_NETWORK_LOGGING',
    defaultValue: true,
  );
}

final class _ProductionConfig implements EnvironmentConfig {
  @override
  AppEnvironment get environment => AppEnvironment.production;

  @override
  String get medbookApiBaseUrl => _readMedbookApiBaseUrl();

  @override
  bool get enableNetworkLogging => false;
}

String _readMedbookApiBaseUrl() {
  const configuredBaseUrl = String.fromEnvironment('MEDBOOK_API_BASE_URL');
  final baseUrl = configuredBaseUrl.trim();

  if (baseUrl.isEmpty) {
    throw StateError(
      'MEDBOOK_API_BASE_URL is required. '
      'Pass it using --dart-define or --dart-define-from-file.',
    );
  }

  final uri = Uri.tryParse(baseUrl);
  if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
    throw StateError(
      'MEDBOOK_API_BASE_URL must be a valid absolute URL.',
    );
  }

  return baseUrl;
}
