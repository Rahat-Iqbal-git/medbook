import 'package:bloc/bloc.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._clinicalReferenceRepository) : super(const HomeLoading());

  final ClinicalReferenceRepository _clinicalReferenceRepository;

  Future<void> synchronize() async {
    emit(const HomeLoading());

    final result = await _clinicalReferenceRepository.synchronize();
    await result.match(
      (failure) async => emit(HomeFailure(failure)),
      _loadOverview,
    );
  }

  Future<void> _loadOverview(SyncOutcome outcome) async {
    final result = await _clinicalReferenceRepository.getOverview();
    result.match(
      (failure) => emit(HomeFailure(failure)),
      (overview) => emit(HomeReady(syncOutcome: outcome, overview: overview)),
    );
  }
}
