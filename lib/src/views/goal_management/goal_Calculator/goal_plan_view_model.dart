import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mf_app/src/app/repository/goal_management/goal_management_repo.dart';
import 'package:mf_app/src/app/repository/models/goal_management/goal_management_model.dart';

abstract class GoalPlanState {}

class GoalPlanInitial implements GoalPlanState {}

class GoalPlanLoading implements GoalPlanState {}

class GoalPlanError implements GoalPlanState {
  final String error;

  GoalPlanError({required this.error});
}

class GoalPlanLoaded implements GoalPlanState {
  final RecommendedFunds recommendedFunds;

  GoalPlanLoaded({required this.recommendedFunds});
}

class GoalManagerProps {
  final double monthlyInvestment;
  final double returnRate;
  final int years;

  GoalManagerProps(
      {required this.monthlyInvestment,
      required this.returnRate,
      required this.years});
}

class ChartData {
  final int years;
  final double investment;
  final double returnEarned;

  ChartData(
      {required this.years,
      required this.investment,
      required this.returnEarned});
}

class GoalPlanViewModel {
  final GoalManagementRepository goalManagementRepository;
  final List<GoalManagerProps> goalManagerProps = [];
  final List<ChartData> chartData = [];

  GoalPlanViewModel({required this.goalManagementRepository});
  List<ChartData> generateChartData(GoalManagerProps props) {
    final double monthlyInvestment = props.monthlyInvestment;
    final double returnRate = props.returnRate;
    final int years = props.years;

    final List<double> totalReturns = [];
    final List<double> interest = [];

    for (int i = 1; i <= years; i++) {
      final double returnsValue = calculateTotalReturns(
        monthlyInvestment,
        i,
        returnRate,
      );

      final double x = returnsValue - monthlyInvestment * 12 * i;
      interest.add(x);
      totalReturns.add(returnsValue - x);
      ChartData singleChartData = ChartData(
          years: i,
          investment: totalReturns[i - 1],
          returnEarned: interest[i - 1]);

      chartData.add(singleChartData);
    }
    // print(monthlyInvestment);
    // print(x);
    // print()

    return chartData;
  }

  double calculateTotalReturns(
      double monthlyInvestment, int years, double returns) {
    final double monthlyReturns = returns / 12;
    final double futureValue = monthlyInvestment *
        (((pow(1 + monthlyReturns, years * 12) - 1) * (1 + monthlyReturns)) /
            monthlyReturns);

    return futureValue;
  }

  final ValueNotifier<GoalPlanState> _goalPlanNotifier =
      ValueNotifier(GoalPlanInitial());
  ValueListenable<GoalPlanState> get goalPlanNotifier => _goalPlanNotifier;

  Future<RecommendedFunds> getRecommendedFunds() async {
    return await goalManagementRepository.getAllFunds(1, 5, 3);
  }

  Future<void> initialise() async {
    _goalPlanNotifier.value = GoalPlanLoading();
    try {
      final recommendedFunds = await getRecommendedFunds();
      _goalPlanNotifier.value =
          GoalPlanLoaded(recommendedFunds: recommendedFunds);
    } catch (e) {
      _goalPlanNotifier.value = GoalPlanError(error: e.toString());
      rethrow;
    }
  }
}
