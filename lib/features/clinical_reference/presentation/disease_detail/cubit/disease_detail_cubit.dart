import 'package:bloc/bloc.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';

part 'disease_detail_state.dart';

class DiseaseDetailCubit extends Cubit<DiseaseDetailState> {
  DiseaseDetailCubit(this._clinicalReferenceRepository)
    : super(const DiseaseDetailLoading());

  final ClinicalReferenceRepository _clinicalReferenceRepository;

  Future<void> load(int id) async {
    emit(const DiseaseDetailLoading());
    final result = await _clinicalReferenceRepository.getDiseaseDetails(id: id);
    result.match(
      (failure) => emit(DiseaseDetailFailure(failure)),
      (details) => emit(DiseaseDetailLoaded(details)),
    );
  }
}
