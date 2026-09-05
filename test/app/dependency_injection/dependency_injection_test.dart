import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:medbook/app/dependency_injection/dependency_injection.dart';
import 'package:medbook/core/config/config.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';
import 'package:medbook/features/clinical_reference/data/synchronization/clinical_reference_synchronizer.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';

void main() {
  test('registers the clinical reference data graph', () {
    final serviceLocator = GetIt.asNewInstance();

    configureDependencies(
      environmentConfig: const _EnvironmentConfig(),
      serviceLocator: serviceLocator,
    );

    expect(serviceLocator.isRegistered<ClinicalDatabase>(), isTrue);
    expect(
      serviceLocator.isRegistered<ClinicalReferenceLocalDataSource>(),
      isTrue,
    );
    expect(
      serviceLocator.isRegistered<ClinicalReferenceSynchronizer>(),
      isTrue,
    );
    expect(serviceLocator.isRegistered<ClinicalReferenceRepository>(), isTrue);
    expect(serviceLocator<ClinicalReferenceRepository>(), isNotNull);
  });
}

final class _EnvironmentConfig implements EnvironmentConfig {
  const _EnvironmentConfig();

  @override
  bool get enableNetworkLogging => false;

  @override
  AppEnvironment get environment => AppEnvironment.development;

  @override
  String get medbookApiBaseUrl => 'https://example.test/';
}
