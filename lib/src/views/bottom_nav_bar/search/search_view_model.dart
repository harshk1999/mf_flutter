import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/funds_repository/funds_repository.dart';
import 'package:mf_app/src/app/repository/models/explore_models/search_model.dart';

abstract class SearchState {}

class SearchInitial implements SearchState {}

class SearchLoading implements SearchState {}

class SearchError implements SearchState {
  final String error;

  SearchError({required this.error});
}

class SearchResultLoaded implements SearchState {
  final List<SearchResult> searchResultList;

  SearchResultLoaded({required this.searchResultList});
}

class SearchViewModel {
  Timer? _timer;
  final FundsRepository _fundsRepository;

  SearchViewModel({required FundsRepository fundsRepository})
      : _fundsRepository = fundsRepository;

  final ValueNotifier<SearchState> _searchNotifier =
      ValueNotifier(SearchInitial());
  ValueListenable<SearchState> get searchNotifier => _searchNotifier;

  Future<List<SearchResult>> fetchSearchResult(String name) async {
    return await _fundsRepository.getSearchResult(name, 3);
  }

  Future<void> onChanged(String val) async {
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
      }
    }
    _timer = Timer(const Duration(milliseconds: 500), () async {
      _searchNotifier.value = SearchLoading();
      try {
        final searchResultList = await _fundsRepository.getSearchResult(val, 3);
        _searchNotifier.value =
            SearchResultLoaded(searchResultList: searchResultList);
      } catch (e) {
        _searchNotifier.value = SearchError(error: e.toString());
        rethrow;
      }
    });
  }
}
