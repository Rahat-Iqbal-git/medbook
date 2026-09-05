import 'package:medbook/core/network/base_dio_client/base_dio_client.dart';

final class MedbookApiClient extends BaseDioClient {
  MedbookApiClient(
    super.dio, {
    required super.baseUrl,
    super.enableLogging = false,
    super.failureMapper,
  });
}
