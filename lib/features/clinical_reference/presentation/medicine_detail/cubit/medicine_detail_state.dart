part of 'medicine_detail_cubit.dart';

sealed class MedicineDetailState {
  const MedicineDetailState();
}

final class MedicineDetailLoading extends MedicineDetailState {
  const MedicineDetailLoading();
}

final class MedicineDetailLoaded extends MedicineDetailState {
  const MedicineDetailLoaded(this.details);

  final MedicineDetails details;
}

final class MedicineDetailFailure extends MedicineDetailState {
  const MedicineDetailFailure(this.failure);

  final Failure failure;
}
