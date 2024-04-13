import 'dart:math';

import 'package:flutter/foundation.dart';

// class GoalManagerData {
//   final double reqAmt;
//   final List<double> totalReturns;
//   final List<double> interest;

//   GoalManagerData(
//       {required this.reqAmt,
//       required this.totalReturns,
//       required this.interest});
// }

class GoalManagerProps {
  final double monthlyInvestment;
  final double returnRate;
  final int years;

  GoalManagerProps(
      {required this.monthlyInvestment,
      required this.returnRate,
      required this.years});
}

class GoalCalculatorViewModel {
  List<String> getAnnualReturnNames() {
    final List<String> annualReturnList = [
      'Aggressive',
      'Balanced',
      'Conservative'
    ];
    return annualReturnList;
  }

  final ValueNotifier<String> _toggleNotifier =
      ValueNotifier<String>('Aggressive');
  ValueListenable<String> get toggleNotifier => _toggleNotifier;

  void toggleFilterNames(String newValue) {
    _toggleNotifier.value = newValue;
  }

  double calculateInflationAdjustedValue(
      double presentValue, double years, double inflation) {
    inflation = 0.06;
    double p = years * 12;
    double x = 1 + inflation / 12;
    double y = presentValue * pow(x, p);
    return y;
  }

  double pv(double presentValue, double years, double interestRate,
      double inflation) {
    double i = interestRate / 100 / 12;

    double ym = years * 12;

    double a = 1 + i;

    double b = pow(a, ym).toDouble();

    double c = b - 1;

    double yearlyPV =
        (i * calculateInflationAdjustedValue(presentValue, years, inflation)) /
            c;

    return yearlyPV;
  }

  (List<double>, List<double>) generateData(GoalManagerProps props) {
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
    }

    return (totalReturns, interest);
  }

  double calculateTotalReturns(
      double monthlyInvestment, int years, double returns) {
    final double monthlyReturns = returns / 12;
    final double futureValue = monthlyInvestment *
        (((pow(1 + monthlyReturns, years * 12) - 1) * (1 + monthlyReturns)) /
            monthlyReturns);

    return futureValue;
  }

  // GoalManagerData generateGoalManagerData({
  //   required double estimatedCost,
  //   required double inflationRate,
  //   required double monthlyInvestment,
  //   required double returnRate,
  //   required int years,
  // }) {
  //   List<double> totalReturns = [];
  //   List<double> interest = [];
  //   double reqAmt = requiredMonthlyInvestment(
  //     years,
  //     returnRate,
  //     estimatedCost,
  //     inflationRate,
  //   );

  //   for (int i = 1; i <= years; i++) {
  //     double returnsValue = calculateTotalReturns(
  //       monthlyInvestment,
  //       i,
  //       returnRate,
  //     );

  //     double x = returnsValue - monthlyInvestment * 12 * i;
  //     interest.add(x);
  //     totalReturns.add(returnsValue);
  //   }

  //   return GoalManagerData(
  //       reqAmt: reqAmt, totalReturns: totalReturns, interest: interest);
  // }

  // double requiredMonthlyInvestment(
  //   int years,`
  //   double returnRate,
  //   double estimatedCost,
  //   double inflationRate,
  // ) {
  //   double monthlyReturns = returnRate / 12;

  //   double futureCost = estimatedCost * pow(1 + inflationRate, years);

  //   double requiredMonthlyInvestment = (futureCost * monthlyReturns) /
  //       (pow(1 + monthlyReturns, years * 12) - 1);

  //   return requiredMonthlyInvestment;
  // }

  // double calculateTotalReturns(
  //   double monthlyInvestment,
  //   int years,
  //   double returns,
  // ) {
  //   double monthlyReturns = returns / 12;
  //   double futureValue = monthlyInvestment *
  //       ((pow(1 + monthlyReturns, years * 12) - 1) / monthlyReturns);

  //   return futureValue;
  // }

  // final ValueNotifier<String?> _errorNotifier = ValueNotifier(null);
  // ValueListenable<String?> get errorNotifier => _errorNotifier;

  // String? validatePassword(String value) {
  //   if (value.isNotEmpty) {
  //     _errorNotifier.value = 'TextField cannot be empty';
  //   }
  //   return null;
  // }
}
