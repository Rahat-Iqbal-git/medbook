import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(
    this._clinicalReferenceRepository, {
    this.debounceDuration = const Duration(milliseconds: 300),
  }) : super(const SearchIdle());

  final ClinicalReferenceRepository _clinicalReferenceRepository;
  final Duration debounceDuration;
  Timer? _debounce;
  int _requestNumber = 0;

  void queryChanged(String query) {
    _debounce?.cancel();
    final requestNumber = ++_requestNumber;

    if (query.trim().isEmpty) {
      emit(const SearchIdle());
      return;
    }

    emit(SearchLoading(query));
    _debounce = Timer(
      debounceDuration,
      () => unawaited(_search(query, requestNumber)),
    );
  }

  Future<void> _search(String query, int requestNumber) async {
    final result = await _clinicalReferenceRepository.search(query: query);
    if (isClosed || requestNumber != _requestNumber) return;

    result.match(
      (failure) => emit(SearchFailure(query: query, failure: failure)),
      (results) => emit(
        results.isEmpty
            ? SearchEmpty(query)
            : SearchResults(query: query, results: results),
      ),
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
