import 'package:flutter_test/flutter_test.dart';
import 'package:medbook/core/config/config.dart';

void main() {
  group('EnvironmentFactory', () {
    test('creates development configuration', () {
      final config = EnvironmentFactory.create(AppEnvironment.development);

      expect(config.environment, AppEnvironment.development);
      expect(config.enableNetworkLogging, isTrue);
    });

    test('creates staging configuration', () {
      final config = EnvironmentFactory.create(AppEnvironment.staging);

      expect(config.environment, AppEnvironment.staging);
      expect(config.enableNetworkLogging, isTrue);
    });

    test('always disables network logging in production', () {
      final config = EnvironmentFactory.create(AppEnvironment.production);

      expect(config.environment, AppEnvironment.production);
      expect(config.enableNetworkLogging, isFalse);
    });

    test('requires an API base URL', () {
      final config = EnvironmentFactory.create(AppEnvironment.development);

      expect(
        () => config.medbookApiBaseUrl,
        throwsA(isA<StateError>()),
      );
    });
  });
}
