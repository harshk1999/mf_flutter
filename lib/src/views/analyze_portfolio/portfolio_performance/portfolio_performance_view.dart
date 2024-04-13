import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mf_app/src/app/bloc/user_bloc.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/analyze_portfolio/portfolio_performance/helper/all_mutual_funds_container.dart';
import 'package:mf_app/src/views/analyze_portfolio/portfolio_performance/portfolio_performance_view_model.dart';
import 'package:provider/provider.dart';

class PortfolioPerformanceView extends StatefulWidget {
  const PortfolioPerformanceView({super.key});

  @override
  State<PortfolioPerformanceView> createState() =>
      _PortfolioPerformanceViewState();
}

class _PortfolioPerformanceViewState extends State<PortfolioPerformanceView> {
  late final PortfolioPerformanceViewModel ppvm;
  late final List<Color> greenShades;
  late final List<Color> blueShades;

  @override
  void initState() {
    super.initState();
    ppvm = context.read<PortfolioPerformanceViewModel>();
    ppvm.getportfolioAnalysis(context.read<UserBloc>().user.value!.mobileNo);
    greenShades = const [
      Color(0xFF079600),
      Color(0xFF21B01A),
      Color(0xFF52C14D),
      Color(0xff84D380),
      Color(0xff9CDC99),
      Color(0xffCEEDCC)
    ];

    blueShades = const [
      Color(0xFF0A5AA0),
      Color(0xFF0D74CE),
      Color(0xFF268EE8),
      Color(0xff3E9AEA),
      Color(0xff6EB3EF),
      Color(0xffB7D9F7)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.bottomNavBarHome);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const ScrollPhysics(),
          child: ValueListenableBuilder(
              valueListenable: ppvm.portfolioPerformanceNotifier,
              builder: (_, ppState, __) {
                if (ppState is PortfolioPerformanceLoaded) {
                  List<PieChartSectionData> pieChartSectionDataForSectors =
                      List.generate(6, (index) {
                    return PieChartSectionData(
                      value: ppState.portfolioMfCentral.analysis
                          .sectorAnalysis[index].value,
                      title: '',
                      color: greenShades[index % greenShades.length],
                    );
                  });

                  List<PieChartSectionData> pieChartSectionDataForCompanies =
                      List.generate(6, (index) {
                    return PieChartSectionData(
                      value: ppState.portfolioMfCentral.analysis
                          .companyAnalysis[index].value,
                      title: '',
                      color: blueShades[index % blueShades.length],
                    );
                  });
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Your Portfolio Performance',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        height: 160,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 15),
                                  blurRadius: 20,
                                  color:
                                      const Color(0xffDDE0E7).withOpacity(0.15))
                            ],
                            border: Border.all(
                                width: 1, color: const Color(0xffDDE0E7)),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Current amount',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff5F6570)),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Text(
                                  '₹ ${ppState.portfolioMfCentral.currentMarketValue}',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  decoration: const BoxDecoration(
                                      color: Color(0xffEFF1F5),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6))),
                                  child: const Text(
                                    '1D',
                                    style: TextStyle(
                                        color: Color(0xff5F6570),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  '₹ ${ppState.portfolioMfCentral.oneDayReturn}',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '(${ppState.portfolioMfCentral.oneDayReturn}%)',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Color(0xff27AA6B)),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Invested amount',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5F6570)),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      ppState.portfolioMfCentral
                                          .currentInvestedValue
                                          .toString(),
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Return (XIRR)',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff5F6570)),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          ppState
                                              .portfolioMfCentral.portfolioXirr
                                              .toStringAsFixed(2),
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          '(${ppState.portfolioMfCentral.portfolioReturn.toStringAsFixed(2)}%)',
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xff27AA6B)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Category Distribution',
                        style: TextStyle(
                            color: Color(0xff313439),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 16, right: 16, top: 20),
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: const Color(0xffEFF1F5)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: LayoutBuilder(
                          builder: (_, BoxConstraints constraints) {
                            final maxWidth = constraints.maxWidth;
                            final categoryAnalysis = ppState
                                .portfolioMfCentral.analysis.categoryAnalysis;

                            return Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  child: Row(
                                    children: List.generate(
                                      categoryAnalysis.length,
                                      (index) {
                                        final sector = categoryAnalysis[index];
                                        final percentage = sector.value;
                                        final width =
                                            (maxWidth * percentage / 100)
                                                .toDouble();
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: greenShades[
                                                index % greenShades.length],
                                          ),
                                          width: width >= 0 ? width : 0,
                                          height: 32,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: categoryAnalysis.length,
                                      itemBuilder: (_, index) {
                                        return Row(
                                          children: [
                                            Container(
                                              height: 20,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(2.5)),
                                                color: greenShades[
                                                    index % greenShades.length],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              categoryAnalysis[index].name,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Color(0xff313439)),
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              '${categoryAnalysis.length} funds',
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color(0xff5F6570)),
                                            ),
                                            const Spacer(),
                                            Text(
                                              '${categoryAnalysis[index].value.toString()} %',
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Color(0xff313439)),
                                            )
                                          ],
                                        );
                                      }),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Equity Allocation',
                        style: TextStyle(
                            color: Color(0xff313439),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 15),
                                  blurRadius: 15,
                                  color:
                                      const Color(0xffE3E5EB).withOpacity(0.1))
                            ],
                            border: Border.all(
                                color: const Color(0xffEFF1F5), width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 224,
                              child: PieChart(PieChartData(
                                  sections: pieChartSectionDataForSectors)),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(6, (index) {
                                final sectorAnalysis = ppState
                                    .portfolioMfCentral
                                    .analysis
                                    .sectorAnalysis[index];
                                return Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(2.5)),
                                        color: greenShades[
                                            index % greenShades.length],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      sectorAnalysis.name,
                                      style: const TextStyle(
                                          color: Color(0xff7E838D),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${sectorAnalysis.value.toStringAsFixed(2)} %',
                                      style: const TextStyle(
                                          color: Color(0xff161719),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    )
                                  ],
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 15),
                                  blurRadius: 15,
                                  color:
                                      const Color(0xffE3E5EB).withOpacity(0.1))
                            ],
                            border: Border.all(
                                color: const Color(0xffEFF1F5), width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 224,
                              child: PieChart(PieChartData(
                                  sections: pieChartSectionDataForCompanies)),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(6, (index) {
                                final companyAanalysis = ppState
                                    .portfolioMfCentral
                                    .analysis
                                    .companyAnalysis[index];
                                return Row(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(2.5)),
                                        color: blueShades[
                                            index % blueShades.length],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Wrap(children: [
                                      Text(
                                        companyAanalysis.name,
                                        style: const TextStyle(
                                            color: Color(0xff7E838D),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                    ]),
                                    const Spacer(),
                                    Text(
                                      '${companyAanalysis.value.toStringAsFixed(2)} %',
                                      style: const TextStyle(
                                          color: Color(0xff161719),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    )
                                  ],
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'All Mutual Funds',
                        style: TextStyle(
                            color: Color(0xff313439),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        children: List.generate(
                            ppState.portfolioMfCentral.fundsDetail.length,
                            (index) {
                          final mutualFund =
                              ppState.portfolioMfCentral.fundsDetail[index];

                          return AllMutualFundsContainer(
                              iconUrl: 'assets/images/png/sbi_icon.png',
                              fundName: mutualFund.name,
                              currentAmount:
                                  mutualFund.fundMarketValue.toStringAsFixed(2),
                              invstAmount: mutualFund.fundInvestedValue
                                  .toStringAsFixed(1),
                              returnXirr: mutualFund.xirr);
                        }),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.bottomNavBarHome);
                        },
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            margin: const EdgeInsets.symmetric(vertical: 24),
                            decoration: BoxDecoration(
                                color: const Color(0xff3F4599),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 8),
                                      blurRadius: 15,
                                      color: const Color(0xffE3E5EB)
                                          .withOpacity(0.5))
                                ],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6))),
                            child: const Center(
                              child: Text(
                                'Go to Dashboard',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }

                if (ppState is PortfolioPerformanceError) {
                  return Center(
                    child: Text(ppState.error),
                  );
                }

                return Dialog(
                  child: Container(
                    child: Image.asset('assets/images/png/scanner.png'),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
