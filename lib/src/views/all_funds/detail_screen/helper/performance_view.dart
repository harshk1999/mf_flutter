import 'package:flutter/material.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/detail_view_model.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/helper/fix_slider_performance.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/helper/performance_fund_Container.dart';
import 'package:provider/provider.dart';

class PerformanceView extends StatefulWidget {
  const PerformanceView({super.key});

  @override
  State<PerformanceView> createState() => _PerformanceViewState();
}

class _PerformanceViewState extends State<PerformanceView>
    with SingleTickerProviderStateMixin {
  late final DetailsViewModel dvm;
  late TabController _tabController;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    dvm = context.read<DetailsViewModel>();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: dvm.detailsNotifier,
        builder: (_, performanceState, __) {
          if (performanceState is DetailsLoaded) {
            int length = performanceState.performanceList.length > 5
                ? 5
                : performanceState.performanceList.length;
            if (isExpanded) {
              length = performanceState.performanceList.length;
            }

            int itemToBe = length - 1;
            for (int i = 0; i < (length - 1); i++) {
              if (performanceState.performanceList[i].datumReturn >=
                      performanceState.fund.returnPercentage &&
                  performanceState.fund.returnPercentage >=
                      performanceState.performanceList[i + 1].datumReturn) {
                itemToBe = i + 1;
                break;
              }
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'Comparison with other ${performanceState.singleFundDetails.details.subCategory} funds',
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff161719),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'On Feb ${DateTime.now().day}, ${DateTime.now().year}',
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5a5f69),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: LayoutBuilder(builder: (_, constr) {
                      double lowest = performanceState
                          .performanceList[
                              performanceState.performanceList.length - 1]
                          .datumReturn;
                      final double mid = performanceState.fund.returnPercentage;
                      double highest =
                          performanceState.performanceList[0].datumReturn;
                      if (performanceState.fund.returnPercentage < lowest) {
                        lowest = performanceState.fund.returnPercentage;
                      }
                      if (performanceState.fund.returnPercentage > highest) {
                        highest = performanceState.fund.returnPercentage;
                      }
                      final nMid = mid - lowest;
                      final nhighest = highest - lowest;
                      return Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          const SizedBox(
                            height: 66,
                          ),
                          Positioned(
                            bottom: 5,
                            left: 0,
                            child: FixSlider(
                              width: constr.maxWidth,
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 200),
                            left: (nMid / nhighest) * constr.maxWidth - 27.5,
                            bottom: 30,
                            child: Column(
                              children: [
                                Text(mid.toStringAsFixed(2) + "%"),
                                const Text("This Fund"),
                              ],
                            ),
                          ),
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 200),
                            left: (nMid / nhighest) * constr.maxWidth,
                            bottom: 0,
                            child: Container(
                              height: 26,
                              width: 17,
                              decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF),
                                  border: Border.all(
                                      width: 3, color: const Color(0xff27AA6B)),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(2))),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                  Container(
                      // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
                      margin: const EdgeInsets.only(
                          top: 30, left: 20, right: 20, bottom: 24),
                      height: 40,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          color: Color(0xffF7F8FA)),
                      child: TabBar(
                          onTap: (value) {
                            dvm.changePerfBenchMark(value);
                          },
                          controller: _tabController,
                          indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 8),
                                    blurRadius: 15,
                                    color: Color(0xffD1D4DC))
                              ]),
                          indicatorColor: Colors.transparent,
                          tabs: const [
                            Tab(
                              child: Text(
                                "1M",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff5f646f),
                                  height: 20 / 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Tab(
                                child: Text(
                              "3M",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5f646f),
                                height: 20 / 13,
                              ),
                              textAlign: TextAlign.center,
                            )),
                            Tab(
                                child: Text(
                              "6M",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5f646f),
                                height: 20 / 13,
                              ),
                              textAlign: TextAlign.center,
                            )),
                            Tab(
                                child: Text(
                              "1Y",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5f646f),
                                height: 20 / 13,
                              ),
                              textAlign: TextAlign.center,
                            )),
                            Tab(
                                child: Text(
                              "3Y",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5f646f),
                                height: 20 / 13,
                              ),
                              textAlign: TextAlign.center,
                            )),
                            Tab(
                                child: Text(
                              "5Y",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff5f646f),
                                height: 20 / 13,
                              ),
                              textAlign: TextAlign.center,
                            )),
                          ])),
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 26),
                        child: Text(
                          "Fund Name",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7e838d),
                            height: 18 / 12,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 26),
                        child: Text(
                          "Annual Return",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff7e838d),
                            height: 18 / 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: length,
                      itemBuilder: (_, index) {
                        if (index == itemToBe) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 8),
                            child: PerformanceFundListContainer(
                                selected: true,
                                index: (index + 1).toString(),
                                fundName: performanceState.fund.name,
                                fundReturn: performanceState
                                    .fund.returnPercentage
                                    .toStringAsFixed(2)),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 8),
                          child: PerformanceFundListContainer(
                              index: (index + 1).toString(),
                              fundName:
                                  performanceState.performanceList[index].name,
                              fundReturn: performanceState
                                  .performanceList[index].datumReturn
                                  .toStringAsFixed(2)),
                        );
                      }),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = true;
                      });
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 68, right: 68, top: 24),
                      child: Text(
                        "See all  ${performanceState.singleFundDetails.details.subCategory} Fund (Fund Type)",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontFamily: "Poppins",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3f4599),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
