import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/goal_management/goal_Calculator/goal_plan_view_model.dart';
import 'package:mf_app/src/views/goal_management/helper/goal_management_conatiner.dart';
import 'package:mf_app/src/views/goal_management/helper/goal_plan_funds_container.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GoalPlanView extends StatefulWidget {
  final String img;
  final String goalName;
  final double monthlyInvestmentRequired;
  final double inflationAdjustedAmount;
  final double projectedSavings;
  final int years;
  const GoalPlanView({
    super.key,
    required this.img,
    required this.goalName,
    required this.monthlyInvestmentRequired,
    required this.inflationAdjustedAmount,
    required this.projectedSavings,
    required this.years,
  });

  @override
  State<GoalPlanView> createState() => _GoalPlanViewState();
}

class _GoalPlanViewState extends State<GoalPlanView> {
  late final GoalPlanViewModel gpvm;
  late final List<ChartData> chartData;
  @override
  void initState() {
    super.initState();
    gpvm = context.read<GoalPlanViewModel>();
    chartData = gpvm.generateChartData(GoalManagerProps(
        monthlyInvestment: widget.monthlyInvestmentRequired,
        returnRate: 0.12,
        years: widget.years));

    gpvm.initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: ValueListenableBuilder(
              valueListenable: gpvm.goalPlanNotifier,
              builder: (_, goalPlanState, __) {
                if (goalPlanState is GoalPlanLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            SvgPicture.asset(
                              widget.img,
                              height: 33,
                              width: 46,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Your ${widget.goalName} Plan !',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 263,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: const Color(0xffF7F8FA)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              // margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 120,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xff27AA6B).withOpacity(0.06),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(2))),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/svg/coins.svg',
                                      height: 17.62,
                                      width: 29.64,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '₹ ${widget.monthlyInvestmentRequired.toStringAsFixed(2)}'
                                              .toString(),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24,
                                              color: Color(0xff27AA6B)),
                                        ),
                                        const Text(
                                          '/',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 32,
                                              color: Color(0xff27AA6B)),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: Text('month',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color: Color(0xff27AA6B))),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    const Text(
                                      'You may invest this amount to achieve your Goal',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color(0xff161719)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Your calculations for the goal Plan',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Inflation Adjusted Target Amount',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 13,
                                                  color: Color(0xff5F6570)),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 3),
                                              height: 16,
                                              width: 16,
                                              decoration: const BoxDecoration(
                                                  color: Color(0xff3F4599),
                                                  shape: BoxShape.circle),
                                              child: SvgPicture.asset(
                                                  'assets/images/svg/i.svg'),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(
                                          '₹ ${widget.inflationAdjustedAmount.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xff161719),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: SvgPicture.asset(
                                        'assets/images/svg/dot_line.svg'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 9),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'Your Projected Saving',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                              color: Color(0xff5F6570)),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '₹ ${widget.projectedSavings}',
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0xff161719),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        // height: 470,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                width: 1, color: const Color(0xffF7F8FA)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Yearly Chart of investment',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff3F4599),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'Monthly Investment',
                                  style: TextStyle(
                                      color: Color(0xff5F6570),
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  height: 16,
                                  width: 16,
                                  decoration: const BoxDecoration(
                                      color: Color(0xff19BC8A),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  'Interest',
                                  style: TextStyle(
                                      color: Color(0xff5F6570),
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                              height: 337,
                              child: SfCartesianChart(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 28),
                                // title: ChartTitle(
                                //     text: 'Yearly Chart of investment',
                                //     textStyle: const TextStyle(
                                //       fontFamily: 'Poppins',
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.w600,
                                //       color: Color(0xff161719),
                                //     )),

                                tooltipBehavior: TooltipBehavior(
                                  builder: (_, __, ____, _____, ______) {
                                    return Container(
                                      color: Colors.red,
                                      height: 10,
                                      width: 10,
                                    );
                                  },
                                  tooltipPosition: TooltipPosition.pointer,
                                  textStyle:
                                      const TextStyle(color: Colors.black),
                                  color: Colors.white,
                                  enable: true,
                                  borderColor: const Color(0xffEFF1F5),
                                  borderWidth: 1,
                                ),
                                primaryXAxis: CategoryAxis(
                                    majorGridLines:
                                        const MajorGridLines(width: 0)),

                                series: <ChartSeries>[
                                  StackedColumnSeries<ChartData, String>(
                                      dataSource: chartData,
                                      color: const Color(0xff3F4599),
                                      xValueMapper: (ChartData x, _) =>
                                          '${x.years.toString()}Y',
                                      yValueMapper: (ChartData y, _) =>
                                          y.investment),
                                  StackedColumnSeries<ChartData, String>(
                                      isTrackVisible: false,
                                      dataSource: chartData,
                                      color: const Color(0xff19BC8A),
                                      xValueMapper: (ChartData x, _) =>
                                          '${x.years.toString()}Y',
                                      yValueMapper: (ChartData y, _) =>
                                          y.returnEarned)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Container(
                            height: 54,
                            // width: 340,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 82, vertical: 15),
                            decoration: const BoxDecoration(
                              color: Color(0xff3F4599),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            ),
                            child: const Text(
                              'Re-calculate My Goal',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 42,
                      ),
                      const Text(
                        'Explore these funds for your strategy.',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // const GoalPlanFundContainer(
                      //     fundName: 'SBI Long Term Equity Fund',
                      //     fundType: 'Equity',
                      //     fundIcon: 'assets/images/png/sbi_icon.png',
                      //     term: 'Long Term',
                      //     fiveYearReturn: '16.8%',
                      //     fundSize: '12,368.00 Cr',
                      //     fundRating: 5),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      // const GoalPlanFundContainer(
                      //     fundName: 'Kotak Bluechip  Equity Fund',
                      //     fundType: 'Equity',
                      //     fundIcon: 'assets/images/png/kottakpng.png',
                      //     term: 'Long Term',
                      //     fiveYearReturn: '16.8%',
                      //     fundSize: '12,368.00 Cr',
                      //     fundRating: 5),
                      // const SizedBox(
                      //   height: 12,
                      // ),
                      // const GoalPlanFundContainer(
                      //     fundName: 'Nippon Preduntial Equity Fund',
                      //     fundType: 'Equity',
                      //     fundIcon: 'assets/images/png/ICICpred_bank.png',
                      //     term: 'Long Term',
                      //     fiveYearReturn: '16.8%',
                      //     fundSize: '12,368.00 Cr',
                      //     fundRating: 5),
                      // const SizedBox(
                      //   height: 24,
                      // ),
                      Column(
                          children: List.generate(
                              goalPlanState.recommendedFunds.fundInfo!.length,
                              (index) {
                        final recommendedFunds =
                            goalPlanState.recommendedFunds.fundInfo![index];
                        return GoalPlanFundContainer(
                            fundName: recommendedFunds.name,
                            fundType: recommendedFunds.subCategory,
                            fundIcon: recommendedFunds.iconUrl,
                            term: recommendedFunds.category,
                            fiveYearReturn:
                                recommendedFunds.ret5Year.toString(),
                            fundSize: recommendedFunds.fundSize.toString(),
                            fundRating: recommendedFunds.fundRating);
                      })),

                      Container(
                        // height: 550,
                        // width: 390,
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            color: const Color(0xff3F4599).withOpacity(0.05)),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Disclaimer',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Its important to note that incorporating an inflation rate of 6% into financial calculations is a prudent step to account for the decrease in purchasing power over time. By adjusting for inflation, you can better estimate the future value of your financial goals in todays terms. If youre using the SMC Goal Management Calculator and want to include an inflation rate of 6%, make sure to input this rate when prompted for the relevant information. This will help the calculator adjust your financial goals and estimates to reflect the impact of inflation. However, keep in mind that while the calculator can provide useful estimates based on the data and assumptions provided, its always recommended to consult with financial professionals for personalized advice. Additionally, as stated, SMC does not guarantee the accuracy of the outcomes, and actual results may vary. Users should be aware that financial planning involves uncertainties, and factors such as market conditions, economic changes, and personal circumstances can influence the actual results. Therefore, use the calculators outputs as estimations and consider them as part of a broader financial planning strategy.',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Color(0xff5F6570),
                                    height: 1.6),
                                textAlign: TextAlign.start,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }

                if (goalPlanState is GoalPlanError) {
                  return Center(
                    child: Text(goalPlanState.error),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }
}
