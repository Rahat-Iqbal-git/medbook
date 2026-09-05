// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:medbook/app/dependency_injection/clinical_reference_module.dart'
    as _i412;
import 'package:medbook/core/config/config.dart' as _i761;
import 'package:medbook/core/network/medbook_api_client/medbook_api_client.dart'
    as _i679;
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart'
    as _i994;
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart'
    as _i1004;
import 'package:medbook/features/clinical_reference/data/synchronization/clinical_reference_synchronizer.dart'
    as _i721;
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart'
    as _i868;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final clinicalReferenceModule = _$ClinicalReferenceModule();
    gh.lazySingleton<_i361.Dio>(() => clinicalReferenceModule.dio());
    gh.lazySingleton<_i1004.ClinicalDatabase>(
      () => clinicalReferenceModule.clinicalDatabase(),
    );
    gh.lazySingleton<_i679.MedbookApiClient>(
      () => clinicalReferenceModule.apiClient(
        gh<_i361.Dio>(),
        gh<_i761.EnvironmentConfig>(),
      ),
    );
    gh.lazySingleton<_i994.ClinicalReferenceRemoteDataSource>(
      () => clinicalReferenceModule.remoteDataSource(
        gh<_i679.MedbookApiClient>(),
      ),
    );
    gh.lazySingleton<_i994.ClinicalReferenceLocalDataSource>(
      () => clinicalReferenceModule.localDataSource(
        gh<_i1004.ClinicalDatabase>(),
      ),
    );
    gh.lazySingleton<_i721.ClinicalReferenceSynchronizer>(
      () => clinicalReferenceModule.synchronizer(
        gh<_i994.ClinicalReferenceRemoteDataSource>(),
        gh<_i994.ClinicalReferenceLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i868.ClinicalReferenceRepository>(
      () => clinicalReferenceModule.clinicalReferenceRepository(
        gh<_i721.ClinicalReferenceSynchronizer>(),
        gh<_i994.ClinicalReferenceLocalDataSource>(),
      ),
    );
    return this;
  }
}

class _$ClinicalReferenceModule extends _i412.ClinicalReferenceModule {}
