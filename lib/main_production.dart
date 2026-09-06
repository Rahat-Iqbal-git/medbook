import 'package:medbook/app/app.dart';
import 'package:medbook/app/dependency_injection/dependency_injection.dart';
import 'package:medbook/bootstrap.dart';
import 'package:medbook/core/config/config.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';

Future<void> main() async {
  final environmentConfig = EnvironmentFactory.create(
    AppEnvironment.production,
  );
  configureDependencies(environmentConfig: environmentConfig);

  await bootstrap(
    () => App(
      clinicalReferenceRepository: getIt<ClinicalReferenceRepository>(),
    ),
    environmentConfig: environmentConfig,
  );
}
