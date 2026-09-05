part of 'home_cubit.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeReady extends HomeState {
  const HomeReady(this.syncOutcome);

  final SyncOutcome syncOutcome;
}

final class HomeFailure extends HomeState {
  const HomeFailure(this.failure);

  final Failure failure;
}
