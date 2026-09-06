import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:medbook/core/config/config.dart';
import 'package:medbook/core/network/medbook_api_client/medbook_api_client.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';
import 'package:medbook/features/clinical_reference/data/repositories/clinical_reference_repository_impl.dart';
import 'package:medbook/features/clinical_reference/data/synchronization/clinical_reference_synchronizer.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';

@module
abstract class ClinicalReferenceModule {
  @lazySingleton
  Dio dio() => Dio();

  @lazySingleton
  MedbookApiClient apiClient(
    Dio dio,
    EnvironmentConfig environmentConfig,
  ) => MedbookApiClient(
    dio,
    baseUrl: environmentConfig.medbookApiBaseUrl,
    enableLogging: environmentConfig.enableNetworkLogging,
  );

  @lazySingleton
  ClinicalDatabase clinicalDatabase() => ClinicalDatabase.defaults();

  @lazySingleton
  ClinicalReferenceLocalDataSource localDataSource(
    ClinicalDatabase database,
  ) => ClinicalReferenceLocalDataSourceImpl(database);

  @lazySingleton
  ClinicalReferenceRemoteDataSource remoteDataSource(
    MedbookApiClient apiClient,
  ) => ClinicalReferenceRemoteDataSourceImpl(apiClient);

  @lazySingleton
  ClinicalReferenceSynchronizer synchronizer(
    ClinicalReferenceRemoteDataSource remoteDataSource,
    ClinicalReferenceLocalDataSource localDataSource,
  ) => ClinicalReferenceSynchronizer(remoteDataSource, localDataSource);

  @lazySingleton
  ClinicalReferenceRepository clinicalReferenceRepository(
    ClinicalReferenceSynchronizer synchronizer,
    ClinicalReferenceLocalDataSource localDataSource,
  ) => ClinicalReferenceRepositoryImpl(synchronizer, localDataSource);
}
