import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:medbook/app/dependency_injection/dependency_injection.config.dart';
import 'package:medbook/core/config/config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(ignoreUnregisteredTypes: [EnvironmentConfig])
void configureDependencies({
  required EnvironmentConfig environmentConfig,
  GetIt? serviceLocator,
}) {
  (serviceLocator ?? getIt)
    ..registerSingleton<EnvironmentConfig>(environmentConfig)
    ..init();
}
