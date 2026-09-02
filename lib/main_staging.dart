import 'package:medbook/app/app.dart';
import 'package:medbook/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
