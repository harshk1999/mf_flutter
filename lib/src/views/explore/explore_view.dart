import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_app/src/app/bloc/user_bloc.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/explore/explore_view_model.dart';
import 'package:mf_app/src/views/explore/helper/app_tool_card.dart';
import 'package:mf_app/src/views/explore/helper/discover_button.dart';
import 'package:mf_app/src/views/explore/helper/tab_bar_view_widget.dart';
import 'package:mf_app/src/views/explore/helper/top_fund_card_widget.dart';
import 'package:mf_app/src/views/helper/tab_bar_view/tab_bar.dart';
import 'package:mf_app/src/views/explore/helper/total_investment_widget.dart';
import 'package:provider/provider.dart';

class ExploreScreenArguments {
  final int schemeId;
  final String duration;

  ExploreScreenArguments({required this.schemeId, required this.duration});
}

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  late final ExploreViewModel evm;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    evm = context.read<ExploreViewModel>();
    evm.initialise(context.read<UserBloc>().user.value!);

    evm.otpNotifier.addListener(() {
      if (evm.otpNotifier.value != null) {
        if (evm.otpNotifier.value!.isFetched == "true") {
          Navigator.of(context).pushNamed(AppRoutes.portfolioPerformance);
        }
        if (evm.otpNotifier.value!.isFetched == "false") {
          Navigator.of(context).pushNamed(AppRoutes.analyzePortfolioOtp);
        }
      }
    });
    // evm.exploreNotifier.addListener(() {
    //   final state = evm.exploreNotifier.value;
    //   if (state is ExploreLoaded) {
    //     final isFetched = state.msg.$1;
    //     if (isFetched == 'true') {
    //       Navigator.of(context).pushNamed(AppRoutes.PortfolioPerformance);
    //     } else {
    //       Navigator.of(context).pushNamed(AppRoutes.analyzePortfolio);
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushReplacementNamed(AppRoutes.discoverAllFunds);
          },
          child: const DiscoverButton()),
      body: ValueListenableBuilder(
          valueListenable: evm.exploreNotifier,
          builder: (_, exploreSate, __) {
            if (exploreSate is ExploreError) {
              return Center(
                child: Text(exploreSate.error),
              );
            }
            if (exploreSate is ExploreLoaded) {
              return SingleChildScrollView(
                child: DefaultTabController(
                  length: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 430,
                        height: 87,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                          colors: [Color(0x2126eab4), Color(0x115790ff)],
                        )),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            SvgPicture.asset(
                                'assets/images/svg/analyze_portfolio.svg'),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Free',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            fontFamily: 'Poppins'),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text("Portfolio Health Checkup",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (context
                                        .read<UserBloc>()
                                        .user
                                        .value!
                                        .pan
                                        .isNotEmpty) {
                                      evm.requestOtp();
                                    } else {
                                      Navigator.of(context).pushNamed(
                                          AppRoutes.analyzePortfolioPanScreen);
                                    }
                                  },
                                  child: const Text(
                                    'Check now',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff3F4599),
                                        fontSize: 14,
                                        decoration: TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: TotalInvestmentWidget(
                            color1: 0xff3a48bc,
                            color2: 0xff2a9d92,
                            color3: 0xFFFFFFFF,
                            heading: 'Total Investment',
                            currentAmount: '00.00'),
                      ),
                      Container(
                        width: 430,
                        height: 277.28155517578125,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: const Color(0xfff7f8fa)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Text(
                                    "Top SMC Funds",
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        AppRoutes.discoverAllFunds);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        const Text(
                                          'View more',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                              color: Color(0xff3F4599),
                                              decoration:
                                                  TextDecoration.underline),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        SvgPicture.asset(
                                            'assets/images/svg/arrow.svg')
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                controller: _scrollController,
                                physics: const ClampingScrollPhysics(),
                                itemCount: exploreSate.topFunds.length,
                                itemBuilder: (_, index) {
                                  final topfund = exploreSate.topFunds[index];
                                  EdgeInsets padding =
                                      const EdgeInsets.symmetric(
                                          horizontal: 16.0);
                                  if (index == 0) {
                                    padding = const EdgeInsets.only(
                                        left: 20.0, right: 8.0);
                                  } else if (index ==
                                      exploreSate.topFunds.length - 1) {
                                    padding = const EdgeInsets.only(
                                        left: 8.0, right: 20.0);
                                  } else {
                                    padding = const EdgeInsets.symmetric(
                                        horizontal: 10.0);
                                  }
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                          AppRoutes.detailScreen,
                                          arguments: ExploreScreenArguments(
                                              schemeId: topfund.schemeId,
                                              duration: topfund.duration));
                                    },
                                    child: Padding(
                                      padding: padding,
                                      child: TopFundCard(
                                          imgUrl: topfund.iconUrl,
                                          fundName: topfund.name,
                                          rating: topfund.rating.toDouble(),
                                          cagr: topfund.returns),
                                    ),
                                  );
                                },
                                // separatorBuilder: (_, int index) {
                                //   return const SizedBox(
                                //     width: 16,
                                //   );
                                // },
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.returnCalculator);
                                  },
                                  child: const ExploreToolCard(
                                      imgLink:
                                          'assets/icons/svg/calculator.svg',
                                      name: 'Return Calculator '),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.goalManagement);
                                  },
                                  child: const ExploreToolCard(
                                      imgLink: 'assets/icons/svg/goal_icon.svg',
                                      name: 'Goal Management'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ExploreToolCard(
                                    imgLink:
                                        'assets/icons/svg/new_funding_icon.svg',
                                    name: 'New Fund Offering'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      const CustomTabBar(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: TabBarView(children: [
                          TabBarViewWidget(
                              onTapList1: (value) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(AppRoutes.detailScreen,
                                        arguments: ExploreScreenArguments(
                                            schemeId: value, duration: '6M'));
                              },
                              type: 'Equity',
                              popularFunds:
                                  exploreSate.popularFundsInEquity.popularFunds,
                              trendingCategories: exploreSate
                                  .popularFundsInEquity.trendingCategories),
                          TabBarViewWidget(
                              type: 'Debt',
                              popularFunds:
                                  exploreSate.popularFundsInDebt.popularFunds,
                              trendingCategories: exploreSate
                                  .popularFundsInDebt.trendingCategories),
                          TabBarViewWidget(
                              type: 'Hybrid',
                              popularFunds:
                                  exploreSate.popularFundsInHybrid.popularFunds,
                              trendingCategories: exploreSate
                                  .popularFundsInHybrid.trendingCategories),
                          TabBarViewWidget(
                              type: 'ELSS',
                              popularFunds:
                                  exploreSate.popularFundsInElss.popularFunds,
                              trendingCategories: exploreSate
                                  .popularFundsInElss.trendingCategories),
                          TabBarViewWidget(
                              type: 'Other',
                              popularFunds:
                                  // exploreSate.popularFundsInOthers.popularFunds,
                                  const [],
                              trendingCategories: exploreSate
                                  .popularFundsInOthers.trendingCategories
                              // exploreSate
                              //     .popularFundsInOthers.trendingCategories
                              ),
                        ]),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
