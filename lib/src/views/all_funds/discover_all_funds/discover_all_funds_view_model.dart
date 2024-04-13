import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/funds_repository/funds_repository.dart';
import 'package:mf_app/src/app/repository/models/all_funds/all_funds_model.dart';

class FiltersEntity {
  final String name;
  final List<(String, String)> values;
  final bool isBool;
  final bool isRating;
  final String filter;
  List<String> selected = [];

  FiltersEntity({
    required this.name,
    required this.filter,
    this.isRating = false,
    this.isBool = false,
    this.values = const <(String, String)>[],
  });
}

abstract class AllFundsState {}

class AllFundsInitial implements AllFundsState {}

class AllFundsLoading implements AllFundsState {}

class AllFundsError implements AllFundsState {
  final String error;

  AllFundsError({required this.error});
}

class AllFundsLoaded implements AllFundsState {
  final AllFunds allfunds;
  final List<FundInfo> fundInfoList;

  // final List<FundInfo> sortedFundInfoList;

  AllFundsLoaded({required this.fundInfoList, required this.allfunds});
}

abstract class FilterListState {}

class FilterListInitial implements FilterListState {}

class FilterListError implements FilterListState {
  final String error;

  FilterListError({required this.error});
}

class FilterlistLoaded implements FilterListState {
  final List<FiltersEntity> filtersList;

  FilterlistLoaded copyWith(List<FiltersEntity> list) {
    return FilterlistLoaded(filtersList: list);
  }

  FilterlistLoaded({required this.filtersList});
}

class AllFundsViewModel {
  final FundsRepository fundRepo;
  // final ValueNotifier<List<FiltersEntity>> _filterNotifier = ValueNotifier([]);
  // ValueListenable<List<FiltersEntity>> get filterState => _filterNotifier;

  final ValueNotifier<AllFundsState> _allFundNoitifer =
      ValueNotifier<AllFundsState>(AllFundsInitial());

  AllFundsViewModel({required this.fundRepo});

  ValueListenable<AllFundsState> get allFundNotifier => _allFundNoitifer;

  int currentPage = 1; // Initial page
  int totalRecords = 0;
  bool loadingMore = false;
  late List<FundInfo> _listOfFunds;

  Future<AllFunds> getAllFunds() async {
    return await fundRepo.getAllFunds(currentPage, toggleNotifier.value, []);
  }

  Future<void> loadMoreFunds() async {
    if (loadingMore) return; // Prevent concurrent requests

    try {
      // double totalPage = totalRecords / 10;
      loadingMore = true;
      final moreFunds = await fundRepo.getAllFunds(
          currentPage + 1, toggleNotifier.value, getFilterListFromNotifier());

      totalRecords = moreFunds.totalRecords;
      currentPage++;

      final List<FundInfo> fundInfoList = _allFundNoitifer.value
              is AllFundsLoaded
          ? List.from((_allFundNoitifer.value as AllFundsLoaded).fundInfoList)
          : [];
      _listOfFunds.addAll(moreFunds.fundInfo);
      fundInfoList.addAll(moreFunds.fundInfo);
      _allFundNoitifer.value = AllFundsLoaded(
        allfunds: moreFunds,
        fundInfoList: fundInfoList,
      );
    } catch (e) {
      _allFundNoitifer.value = AllFundsError(error: e.toString());
      rethrow;
    } finally {
      loadingMore = false;
    }
  }

  List<String> getFilterNames() {
    List<String> filterNames = [
      'Popularity',
      'fund_size',
      'return_1y',
      'return_3y',
      'return_5y'
    ];
    return filterNames;
  }

  List<String> getFilterNamesForBottomSheet() {
    List<String> filterNamesForBottomSheet = [
      'TOP FUNDS',
      'FUND HOUSES',
      'CATEGORY',
      'SUB - CATEGORY',
      'VOLATILITY',
      'RATING',
      'RETURNS'
    ];
    return filterNamesForBottomSheet;
  }

  List<String> getVolatilityList() {
    List<String> volatilityList = [
      'Low',
      'Moderately Low',
      'Moderate',
      'Moderately High',
      'High',
      'Very High'
    ];
    return volatilityList;
  }

  List<String> getReturnsList() {
    List<String> returnsList = [
      'Less than 0%',
      '0 to 20%',
      '20 to 40%',
      '40 & Above',
    ];
    return returnsList;
  }

  List<String> getYearList() {
    List<String> yearList = [
      '3M',
      '6M',
      '1Yr',
      '3Yr',
      '5Yr',
    ];
    return yearList;
  }

  final ValueNotifier<bool> _visibleNotifier = ValueNotifier<bool>(false);
  ValueListenable<bool> get visibleNotifier => _visibleNotifier;

  void toggleVisibility() {
    _visibleNotifier.value = !_visibleNotifier.value;
  }

  // String _cQuery = "";

  bool isSubString(String first, String second) {
    if (first.length < second.length) {
      return false;
    }
    if (second == first.substring(0, second.length)) {
      return true;
    }
    return false;
  }

  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier<String>("");
  ValueListenable<String> get searchQueryNotifier => _searchQueryNotifier;

  void searchForAllFunds(String query) {
    _searchQueryNotifier.value = query;

    if (_allFundNoitifer.value is AllFundsLoaded) {
      final AllFundsLoaded currentState =
          _allFundNoitifer.value as AllFundsLoaded;

      AllFunds allFund = currentState.allfunds;

      List<FundInfo> matchingFunds = [];

      if (query.isNotEmpty) {
        matchingFunds = _listOfFunds
            .where((fund) =>
                isSubString(fund.name.toLowerCase(), query.toLowerCase()))
            .toList();
      } else {
        matchingFunds = _listOfFunds;
      }

      _allFundNoitifer.value =
          AllFundsLoaded(fundInfoList: matchingFunds, allfunds: allFund);
    }
  }

  Future<void> initialise() async {
    _allFundNoitifer.value = AllFundsLoading();
    try {
      final allFunds = await getAllFunds();
      final allFilters = await getFilterList();
      _listOfFunds = allFunds.fundInfo;
      _filterNotifier.value = FilterlistLoaded(filtersList: allFilters);
      _allFundNoitifer.value = AllFundsLoaded(
          allfunds: AllFunds(
              fundInfo: _listOfFunds,
              totalRecords: totalRecords,
              pageNumber: 1),
          fundInfoList: _listOfFunds);
    } catch (e) {
      _allFundNoitifer.value = AllFundsError(error: e.toString());
      rethrow;
    }
  }

  final ValueNotifier<String> _toggleNotifier =
      ValueNotifier<String>("Popularity");
  ValueListenable<String> get toggleNotifier => _toggleNotifier;

  void toggleFilterNames(String newValue) async {
    _toggleNotifier.value = newValue;
    currentPage = 1;
    final response = await fundRepo.getAllFunds(1, newValue, []);
    _allFundNoitifer.value =
        AllFundsLoaded(fundInfoList: response.fundInfo, allfunds: response);
  }

  final ValueNotifier<FilterListState> _filterNotifier =
      ValueNotifier<FilterListState>(FilterListInitial());

  ValueListenable<FilterListState> get filterNotifier => _filterNotifier;

  Future<List<FiltersEntity>> getFilterList() async {
    List<FiltersEntity> data = [];
    final res = await fundRepo.getFilterList();
    data.add(FiltersEntity(
        name: "TOP FUNDS",
        filter: "is_smc",
        isBool: true,
        values: [("Top SMC Funds", "")]));
    List<(String, String)> values = [];
    for (var a in res.fundHouses) {
      values.add((a.name, "${a.id}"));
    }
    data.add(FiltersEntity(
        name: "FUND HOUSES", values: List.from(values), filter: "fund_houses"));
    values.clear();
    for (var a in res.category) {
      values.add((a.name, a.name));
    }
    data.add(FiltersEntity(
        name: "CATEGORY", values: List.from(values), filter: "category"));
    values.clear();
    for (var a in res.fundsSubCategory) {
      values.add((a.name, a.category));
    }
    data.add(FiltersEntity(
        name: "SUB-CATEGORY",
        values: List.from(values),
        filter: "sub_category"));
    values.clear();
    for (var a in getVolatilityList()) {
      values.add((a, a));
    }
    data.add(FiltersEntity(
        name: "VOLATILITY", values: List.from(values), filter: "volatility"));
    values.clear();
    data.add(
        FiltersEntity(name: "RATING", filter: "fund_rating", isRating: true));
    values.clear();
    for (var a in getReturnsList()) {
      values.add((a, a));
    }
    data.add(FiltersEntity(
        name: "RETURNS", values: List.from(values), filter: "returns"));
    values.clear();
    // for (var a in data) {
    //   print(a.values);
    // }
    return data;
  }

  Future<void> inititaliseBottomSheet() async {
    try {
      // final filtersList = await getFilterList();
      _filterNotifier.value = FilterlistLoaded(filtersList: []);
    } catch (e) {
      _filterNotifier.value = FilterListError(error: e.toString());
    }
  }

  final ValueNotifier<bool> _isExpandedNotifier = ValueNotifier<bool>(false);

  ValueListenable<bool> get isExpandedNotifier => _isExpandedNotifier;

  void onFilterTap(int index1, int index2) {
    if (_filterNotifier.value is! FilterlistLoaded) {
      return;
    }
    final old = _filterNotifier.value as FilterlistLoaded;
    final cFilter = old.filtersList[index1];

    if (cFilter.selected.contains(cFilter.values[index2].$1)) {
      cFilter.selected.remove(cFilter.values[index2].$1);
    } else {
      cFilter.selected.add(cFilter.values[index2].$1);
    }

    _filterNotifier.value = old.copyWith(List.from(old.filtersList));
  }

  List<(String, List<String>)> getFilterListFromNotifier() {
    _allFundNoitifer.value = AllFundsLoading();
    final state = _filterNotifier.value as FilterlistLoaded;
    List<(String, List<String>)> filters = [];
    for (var a in state.filtersList) {
      if (a.selected.isNotEmpty) {
        if (a.isBool) {
          filters.add((a.filter, a.selected.isEmpty ? ["false"] : ["true"]));
          continue;
        }
        filters.add((a.filter, a.selected));
      }
    }
    return filters;
  }

  Future<void> onApply() async {
    final allFunds = await fundRepo.getAllFunds(
        1, _toggleNotifier.value, getFilterListFromNotifier());
    _listOfFunds = allFunds.fundInfo;
    _allFundNoitifer.value = AllFundsLoaded(
        allfunds:
            AllFunds(fundInfo: _listOfFunds, totalRecords: 0, pageNumber: 1),
        fundInfoList: _listOfFunds);
  }

  void clearFilter() async {
    final state = _filterNotifier.value as FilterlistLoaded;
    for (int i = 0; i < state.filtersList.length; i++) {
      state.filtersList[i].selected.clear();
    }
    _filterNotifier.value =
        FilterlistLoaded(filtersList: List.from(state.filtersList));
    final allFunds = await fundRepo.getAllFunds(1, _toggleNotifier.value, []);
    _listOfFunds = allFunds.fundInfo;
    _allFundNoitifer.value = AllFundsLoaded(
        allfunds:
            AllFunds(fundInfo: _listOfFunds, totalRecords: 0, pageNumber: 1),
        fundInfoList: _listOfFunds);
  }
}
