import 'package:bloc/bloc.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';

part 'medicine_detail_state.dart';

class MedicineDetailCubit extends Cubit<MedicineDetailState> {
  MedicineDetailCubit(this._clinicalReferenceRepository)
    : super(const MedicineDetailLoading());

  final ClinicalReferenceRepository _clinicalReferenceRepository;

  Future<void> load(int id) async {
    emit(const MedicineDetailLoading());
    final result = await _clinicalReferenceRepository.getMedicineDetails(
      id: id,
    );
    result.match(
      (failure) => emit(MedicineDetailFailure(failure)),
      (details) => emit(MedicineDetailLoaded(details)),
    );
  }
}
