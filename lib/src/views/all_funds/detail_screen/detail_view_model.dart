// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

import 'package:mf_app/src/app/repository/funds_repository/funds_repository.dart';
import 'package:mf_app/src/app/repository/models/all_funds/faqs.dart';
import 'package:mf_app/src/app/repository/models/all_funds/fund_info_model.dart';
import 'package:mf_app/src/app/repository/models/all_funds/performance_model.dart';
import 'package:mf_app/src/app/repository/models/all_funds/single_fund_detail_model.dart';
import 'package:mf_app/src/app/repository/models/graphs/allocation_model.dart';
import 'package:mf_app/src/app/repository/models/graphs/graphs_model.dart';

abstract class DetailsState {}

class DetailsInitial implements DetailsState {}

class DetailsLoading implements DetailsState {}

class DetailsError implements DetailsState {
  String error;

  DetailsError({required this.error});
}

class DetailsLoaded implements DetailsState {
  final SingleFundDetails singleFundDetails;

  // final Stats stats;
  final FundForGraph fund;
  final List<(DateTime, double)> listOfcoordinates;
  // final Equity equity;
  // final Debt debt;
  final List<Composition> compositionList;
  final List<PerformanceComparsion> performanceList;
  final FundInformation fundInfo;
  final FundQuestions fundQuestions;

  DetailsLoaded(this.fund, this.listOfcoordinates, this.performanceList,
      this.fundInfo, this.fundQuestions, this.compositionList,
      {required this.singleFundDetails});

  DetailsLoaded copyWith({
    SingleFundDetails? singleFundDetails,
    FundForGraph? fund,
    List<(DateTime, double)>? listOfcoordinates,
    List<PerformanceComparsion>? performanceList,
    FundInformation? fundInfo,
    FundQuestions? fundQuestions,
    List<Composition>? compositionList,
  }) {
    return DetailsLoaded(
        singleFundDetails: singleFundDetails ?? this.singleFundDetails,
        fund ?? this.fund,
        listOfcoordinates ?? this.listOfcoordinates,
        performanceList ?? this.performanceList,
        fundInfo ?? this.fundInfo,
        fundQuestions ?? this.fundQuestions,
        compositionList ?? this.compositionList);
  }
}

class DetailsViewModel {
  final FundsRepository detailsRepo;
  final Map<String, List<(DateTime, double)>> _graphData = {};
  final Map<String, FundForGraph> _fundsData = {};
  final Map<String, List<PerformanceComparsion>> _sliderData = {};

  DetailsViewModel({required this.detailsRepo});

  final ValueNotifier<DetailsState> _detailsNotifier =
      ValueNotifier<DetailsState>(DetailsInitial());
  ValueListenable<DetailsState> get detailsNotifier => _detailsNotifier;

  Future<SingleFundDetails> getSingleFundDetails(int schemeId) async {
    return await detailsRepo.getSingleFundDetail(schemeId);
  }

  // Future<Stats> getDetailStats() async {
  //   return await detailsRepo.getStats();
  // }

  Future<FundForGraph> getFundDetails(int schemeId, String duration) async {
    return await detailsRepo.getFundForGraph(schemeId, duration);
  }

  Future<FundInformation> getFundInfo(int id) {
    return detailsRepo.getFundInfo(id);
  }

  Future<FundQuestions> getFaqsForFundInfo() async {
    return await detailsRepo.getFaqs();
  }

  Future<List<(DateTime, double)>> getListOfCoordinates(
      int schemeId, String duration) async {
    final fundDetails = await getFundDetails(schemeId, duration);
    List<(DateTime, double)> listOfcoordinates = [];

    List<DateTime> dates = fundDetails.date;
    List<double> values = fundDetails.value;

    if (dates.length == values.length) {
      for (int i = 0; i < dates.length; i++) {
        listOfcoordinates.add((dates[i], values[i]));
      }
    }
    return listOfcoordinates;
  }

  String selectDuration(int index) {
    if (index == 0) {
      return '1M';
    }

    if (index == 1) {
      return '3M';
    }

    if (index == 2) {
      return '6M';
    }

    if (index == 3) {
      return '1Y';
    }

    if (index == 4) {
      return '3Y';
    }

    if (index == 5) {
      return '5Y';
    }

    return '6M';
  }

  Future<List<Composition>> getCompostionForAllocation(int id) async {
    final composition = await detailsRepo.getCompositionAllocation(id);
    return composition;
  }

  Future<List<PerformanceComparsion>> getPerformances(String time) async {
    return await detailsRepo.getPerformance(time);
  }

  void changePerfBenchMark(int index) {
    final current = _detailsNotifier.value as DetailsLoaded;
    _detailsNotifier.value = current.copyWith(
        performanceList: _sliderData[selectDuration(index)],
        fund: _fundsData[selectDuration(index)]);
  }

  void changeGraphData(int index) {
    final current = _detailsNotifier.value as DetailsLoaded;
    _detailsNotifier.value =
        current.copyWith(listOfcoordinates: _graphData[selectDuration(index)]!);
  }

  Future<void> initialiseDetails(int schemeId, String duration) async {
    _detailsNotifier.value = DetailsLoading();
    try {
      final singleFundDetails = await getSingleFundDetails(schemeId);

      _fundsData["1M"] = await getFundDetails(schemeId, "1M");
      _fundsData["3M"] = await getFundDetails(schemeId, "3M");
      _fundsData["6M"] = await getFundDetails(schemeId, "6M");
      _fundsData["1Y"] = await getFundDetails(schemeId, "1Y");
      _fundsData["3Y"] = await getFundDetails(schemeId, "3Y");
      _fundsData["5Y"] = await getFundDetails(schemeId, "5Y");

      _graphData["1M"] = await getListOfCoordinates(schemeId, "1M");
      _graphData["3M"] = await getListOfCoordinates(schemeId, "3M");
      _graphData["6M"] = await getListOfCoordinates(schemeId, "6M");
      _graphData["1Y"] = await getListOfCoordinates(schemeId, "1Y");
      _graphData["3Y"] = await getListOfCoordinates(schemeId, "3Y");
      _graphData["5Y"] = await getListOfCoordinates(schemeId, "5Y");

      _sliderData["1M"] = await getPerformances("1M");
      _sliderData["3M"] = await getPerformances("3M");
      _sliderData["6M"] = await getPerformances("6M");
      _sliderData["1Y"] = await getPerformances("1Y");
      _sliderData["3Y"] = await getPerformances("3Y");
      _sliderData["5Y"] = await getPerformances("5Y");

      final composition = await getCompostionForAllocation(schemeId);
      // final performanceList = await getPerformances(duration);
      final fundInfo = await getFundInfo(schemeId);
      final ques = await getFaqsForFundInfo();

      _detailsNotifier.value = DetailsLoaded(
          // stats,
          singleFundDetails: singleFundDetails,
          _fundsData[duration]!,
          _graphData[duration]!,
          _sliderData[duration]!,
          fundInfo,
          ques,
          composition

          // equity,
          // debt);
          );
    } catch (e) {
      _detailsNotifier.value = DetailsError(error: e.toString());
      rethrow;
    }
  }
}
