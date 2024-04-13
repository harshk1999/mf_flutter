import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/detail_view_model.dart';
import 'package:provider/provider.dart';

class OverView extends StatefulWidget {
  final String duration;
  final int schemeId;
  final DetailsLoaded state;
  const OverView({
    super.key,
    required this.duration,
    required this.schemeId,
    required this.state,
  });

  @override
  State<OverView> createState() => _OverViewState();
}

class _OverViewState extends State<OverView>
    with SingleTickerProviderStateMixin {
  late final DetailsViewModel ovm;
  late final TabController _tabController;
  late DetailsLoaded overviewState;

  @override
  void initState() {
    super.initState();
    ovm = context.read<DetailsViewModel>();
    _tabController = TabController(length: 6, vsync: this);
    overviewState = widget.state;
  }

  @override
  void didUpdateWidget(OverView oldWidget) {
    super.didUpdateWidget(oldWidget);
    overviewState = widget.state;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Builder(builder: (
          _,
        ) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${overviewState.fund.returnPercentage.toStringAsFixed(2)}%',
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Color(0xff161719)),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Row(
                            children: [
                              Text(
                                '${overviewState.singleFundDetails.stats.hike.toStringAsFixed(2)}%',
                                style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff27aa6b),
                                ),
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: SvgPicture.asset(
                                  'assets/images/svg/up_arrow.svg',
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '${widget.duration} Return',
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xff5F6570)),
                          )
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  color: Color(0xff3A42B2)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'THIS FUND',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color(0xff161719)),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 2),
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2)),
                                  color: Color(0xff20BE8D)),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'NIFTY 50',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color(0xff161719)),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                overviewState.listOfcoordinates.isEmpty
                    ? const SizedBox(
                        height: 100,
                      )
                    : Builder(builder: (context) {
                        final coordinates = overviewState.listOfcoordinates;
                        late double max = coordinates[0].$2;
                        late int maxTime =
                            coordinates[0].$1.millisecondsSinceEpoch;
                        late int minTime =
                            coordinates[0].$1.millisecondsSinceEpoch;
                        late double minVal = coordinates[0].$2;
                        for (var element in coordinates) {
                          if (element.$2 > max) {
                            max = element.$2;
                          }
                          if (element.$1.millisecondsSinceEpoch > maxTime) {
                            maxTime = element.$1.millisecondsSinceEpoch;
                          }
                          if (element.$1.millisecondsSinceEpoch < minTime) {
                            minTime = element.$1.millisecondsSinceEpoch;
                          }
                          if (element.$2 < minVal) {
                            minVal = element.$2;
                          }
                        }
                        return Container(
                          height: 300,
                          // padding: const EdgeInsets.symmetric(vertical: 25),
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 24),
                            child: LineChart(
                              LineChartData(
                                gridData: FlGridData(show: false),
                                titlesData: FlTitlesData(show: false),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: const Color(0xff37434d), width: 0),
                                ),
                                minX: minTime.toDouble(),
                                maxX: maxTime.toDouble(),
                                minY: minVal - (minVal * 0.2),
                                maxY: coordinates
                                    .map((coordinate) => coordinate.$2)
                                    .reduce((a, b) => a > b ? a : b),
                                lineBarsData: [
                                  LineChartBarData(
                                      spots: coordinates
                                          .map((coordinate) => FlSpot(
                                              coordinate.$1.millisecondsSinceEpoch
                                                  .toDouble(),
                                              coordinate.$2))
                                          .toList(),
                                      isCurved: false,
                                      color: const Color(0xff3A42B2),
                                      dotData: FlDotData(show: false),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            const Color(0xff7882E4)
                                                .withOpacity(0.1),
                                            const Color(0xff9EA6F2)
                                                .withOpacity(0.1),
                                            // Color(0xff3A42B2).withOpacity(0.03),
                                            // Color(0xff3A42B2).withOpacity(0.01),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  // height: 44,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: const BoxDecoration(
                      color: Color(0xffF7F8FA),
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: const Color(0xff5F6570),
                      controller: _tabController,
                      indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 8),
                                blurRadius: 15,
                                color: const Color(0xffD1D4DC).withOpacity(0.2))
                          ]),
                      indicatorColor: Colors.transparent,
                      onTap: (value) {
                        ovm.changeGraphData(_tabController.index);
                      },
                      tabs: const [
                        Tab(
                          child: Text(
                            "1M",
                            maxLines: 1,
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Tab(
                            child: Text(
                          "3M",
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )),
                        Tab(
                            child: Text(
                          "6M",
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )),
                        Tab(
                            child: Text(
                          "1Y",
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )),
                        Tab(
                            child: Text(
                          "3Y",
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )),
                        Tab(
                            child: Text(
                          "5Y",
                          maxLines: 1,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )),
                        // Tab(
                        //     child: Text(
                        //   "All",
                        //   maxLines: 1,
                        //   style: TextStyle(
                        //     fontFamily: "Poppins",
                        //     fontSize: 13,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // )),
                      ]),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Important parameters",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff161719),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'NAV (as on 28 nov 23)',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5F6570)),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '₹${overviewState.singleFundDetails.stats.nav}',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0xff161719),
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      "0.40%",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff27aa6b),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/svg/up_arrow.svg',
                                      height: 9,
                                      width: 9,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          // const Spac(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Fund size',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5F6570)),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '₹${overviewState.singleFundDetails.stats.fundSize}Cr',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff161719),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Min SIP',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5F6570)),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '₹${overviewState.singleFundDetails.stats.minSip}',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff161719),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Expense Ratio',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5F6570)),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '${overviewState.singleFundDetails.stats.expenseRatio}%',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff161719),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Exit Load',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5F6570)),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '1.71',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff161719),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Age',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5F6570)),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '8 Years and 7 Months',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff161719),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lock-in',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5F6570)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  '3 Years',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff161719),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Benchmark',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5F6570)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  overviewState.fund.name,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff161719),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Beta',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xff5F6570)),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  overviewState.singleFundDetails.about.beta
                                      .toString(),
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xff161719),
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}
