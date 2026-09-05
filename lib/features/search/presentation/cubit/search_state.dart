part of 'search_cubit.dart';

sealed class SearchState {
  const SearchState();
}

final class SearchIdle extends SearchState {
  const SearchIdle();
}

final class SearchLoading extends SearchState {
  const SearchLoading(this.query);

  final String query;
}

final class SearchResults extends SearchState {
  const SearchResults({required this.query, required this.results});

  final String query;
  final List<ClinicalSearchResult> results;
}

final class SearchEmpty extends SearchState {
  const SearchEmpty(this.query);

  final String query;
}

final class SearchFailure extends SearchState {
  const SearchFailure({required this.query, required this.failure});

  final String query;
  final Failure failure;
}
