import 'package:medbook/app/app.dart';
import 'package:medbook/bootstrap.dart';
import 'package:medbook/core/config/config.dart';

Future<void> main() async {
  final environmentConfig = EnvironmentFactory.create(
    AppEnvironment.staging,
  );

  await bootstrap(
    () => const App(),
    environmentConfig: environmentConfig,
  );
}
