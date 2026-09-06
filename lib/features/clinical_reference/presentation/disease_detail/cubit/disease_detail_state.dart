part of 'disease_detail_cubit.dart';

sealed class DiseaseDetailState {
  const DiseaseDetailState();
}

final class DiseaseDetailLoading extends DiseaseDetailState {
  const DiseaseDetailLoading();
}

final class DiseaseDetailLoaded extends DiseaseDetailState {
  const DiseaseDetailLoaded(this.details);

  final DiseaseDetails details;
}

final class DiseaseDetailFailure extends DiseaseDetailState {
  const DiseaseDetailFailure(this.failure);

  final Failure failure;
}
