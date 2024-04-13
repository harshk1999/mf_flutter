import 'package:flutter/foundation.dart';
import 'package:mf_app/src/app/repository/analyze_your_portfolio/mf_central_repo.dart';
import 'package:mf_app/src/app/repository/funds_repository/funds_repository.dart';
import 'package:mf_app/src/app/repository/models/explore_models/popular_funds_in_category_model.dart';
import 'package:mf_app/src/app/repository/models/explore_models/top_smc_fund_model.dart';
import 'package:mf_app/src/app/repository/models/explore_models/trending_category_model.dart';
import 'package:mf_app/src/app/repository/models/login/otp_model.dart';

class OtpResponseEntity {
  final String message;
  final String isFetched;

  OtpResponseEntity({required this.message, required this.isFetched});
}

abstract class ExploreState {}

class ExploreInitial implements ExploreState {}

class ExploreLoading implements ExploreState {}

class ExploreError implements ExploreState {
  final String error;

  ExploreError({required this.error});
}

typedef SectorCategories = List<(String, List<CategoryDetails>)>;

class ExploreLoaded implements ExploreState {
  // final ExploreDetails exploreDetails;

  final List<TopFunds> topFunds;
  // final SectorCategories trendingCategories;
  final PopularFundsInCategory popularFundsInEquity;
  final PopularFundsInCategory popularFundsInDebt;
  final PopularFundsInCategory popularFundsInHybrid;
  final PopularFundsInCategory popularFundsInElss;
  final PopularFundsInCategory popularFundsInOthers;

  ExploreLoaded(
      // this.trendingCategories,
      this.popularFundsInEquity,
      this.popularFundsInDebt,
      this.popularFundsInHybrid,
      this.popularFundsInElss,
      this.popularFundsInOthers,
      {required this.topFunds});
}

class ExploreViewModel {
  final FundsRepository exploreRepository;
  final MfCentralRepository mfCentralRepository;
  late User _user;

  List<PopularFundsInCategory> listOfPopularfundsInCategory = [];

  final ValueNotifier<ExploreState> _exploreNotifier =
      ValueNotifier<ExploreState>(ExploreInitial());

  ExploreViewModel({
    required this.exploreRepository,
    required this.mfCentralRepository,
  });

  ValueListenable<ExploreState> get exploreNotifier => _exploreNotifier;

  // Future<ExploreDetails> getExploreDetails() async {
  //   return await exploreRepository.getExploreDetails();
  // }

  Future<List<TopFunds>> getTopFunds() async {
    return await exploreRepository.getTopFunds();
  }

  // Future<List<CategoryDetails>> getTrendingCateogriesBySector(
  //     String sector) async {
  //   return await exploreRepository.getCategoriesBySector(sector);
  // }

  final List<String> categoryNameList = [
    'Equity',
    'Debt',
    'Hybrid',
    'Elss',
    'Other'
  ];

  // Future<List<PopularFundsInCategory>> getPopularFundsInCategory() async {
  //   for (int i = 0; i < categoryNameList.length; i++) {
  //     final popularfundInCategory = await exploreRepository
  //         .getPopularFundsInCateogries(categoryNameList[i]);
  //     listOfPopularfundsInCategory.add(popularfundInCategory);
  //   }

  //   return listOfPopularfundsInCategory;
  // }

  // Future<List<(String, List<CategoryDetails>)>> getTrendingCategories() async {
  //   final sectors = ['Equity', 'Debt', 'Hybrid', 'Other'];
  //   final List<(String, List<CategoryDetails>)> trendingCategories = [];

  //   for (final sector in sectors) {
  //     final categories = await getTrendingCateogriesBySector(sector);
  //     trendingCategories.add((sector, categories));
  //   }
  //   return trendingCategories;
  // }

  Future<PopularFundsInCategory> getPopularFundsAndTrendingCategoryForExplore(
      String category) async {
    return await exploreRepository
        .getPopularFundsAndTrendingCateogries(category);
  }

  final ValueNotifier<OtpResponseEntity?> _otpNotifier =
      ValueNotifier<OtpResponseEntity?>(null);
  ValueListenable<OtpResponseEntity?> get otpNotifier => _otpNotifier;

  Future<void> requestOtp() async {
    final pan = _user.pan;
    final mobileNumber = _user.mobileNo;
    final (isFetched, message) =
        await mfCentralRepository.requestOtp(pan, mobileNumber);
    _otpNotifier.value =
        OtpResponseEntity(message: message, isFetched: isFetched);
  }

  Future<void> initialise(User user) async {
    _user = user;
    _exploreNotifier.value = ExploreLoading();
    try {
      // final exploreDetails = await getExploreDetails();
      final topFunds = await getTopFunds();
      // final trendingCategories = await getTrendingCategories();
      final popularFundsInEquity =
          await getPopularFundsAndTrendingCategoryForExplore('Equity');
      final popularFundsInDebt =
          await getPopularFundsAndTrendingCategoryForExplore('Debt');
      final popularFundsInHybrid =
          await getPopularFundsAndTrendingCategoryForExplore('Hybrid');
      final popularFundsInElss =
          await getPopularFundsAndTrendingCategoryForExplore('Elss');
      final popularFundsInOthers =
          await getPopularFundsAndTrendingCategoryForExplore('Others');

      // final msg = await requestOTP();

      _exploreNotifier.value = ExploreLoaded(
        topFunds: topFunds,
        // trendingCategories,
        popularFundsInEquity,
        popularFundsInDebt,
        popularFundsInHybrid,
        popularFundsInElss,
        popularFundsInOthers,
      );
    } catch (e) {
      _exploreNotifier.value = ExploreError(error: e.toString());
      rethrow;
    }
  }
}
