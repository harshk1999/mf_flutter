import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mf_app/src/views/all_funds/detail_screen/detail_view_model.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/helper/Performance_View.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/helper/allocation/allocation_view.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/helper/detail_type_container.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/helper/fund_info_view.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/helper/overview_view.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/helper/tab_bar_for_details.dart';
import 'package:provider/provider.dart';

class AllFundsDetailView extends StatefulWidget {
  final int schemeId;
  final String duration;
  const AllFundsDetailView(
      {super.key, required this.schemeId, required this.duration});

  @override
  State<AllFundsDetailView> createState() => _AllFundsDetailViewState();
}

class _AllFundsDetailViewState extends State<AllFundsDetailView>
    with SingleTickerProviderStateMixin {
  late final DetailsViewModel dvm;
  late final TabController _detailsController;
  @override
  void initState() {
    super.initState();
    dvm = context.read<DetailsViewModel>();
    dvm.initialiseDetails(widget.schemeId, widget.duration);
    _detailsController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: dvm.detailsNotifier,
        builder: (_, detailsState, __) {
          if (detailsState is DetailsLoaded) {
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 54,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                            color: Color(0xff3F4599),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: const Center(
                          child: Text(
                            "SIP Monthly",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFFFFFF),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        height: 54,
                        decoration: const BoxDecoration(
                            color: Color(0xff19BC8A),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: const Center(
                          child: Text(
                            "One Time",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    )),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(85),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  detailsState.singleFundDetails.details.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Color(0xff161719),
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            // const Spacer(),
                            const SizedBox(
                              width: 48,
                            ),
                            SvgPicture.asset(
                              'assets/icons/svg/share.svg',
                              height: 36,
                              width: 36,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            SvgPicture.asset(
                              'assets/icons/svg/sharedetails.svg',
                              height: 36,
                              width: 36,
                            ),
                            const SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              DetailTypeContainer(
                                  text: detailsState
                                      .singleFundDetails.details.category),
                              const SizedBox(
                                width: 10,
                              ),
                              DetailTypeContainer(
                                  text: detailsState
                                      .singleFundDetails.details.subCategory),
                              const SizedBox(
                                width: 10,
                              ),
                              DetailTypeContainer(
                                  text: detailsState
                                      .singleFundDetails.stats.riskometer)
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              body: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TabBarForDetails(controller: _detailsController),
                  Expanded(
                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                    // height: MediaQuery.of(context).size.height,
                    child:
                        TabBarView(controller: _detailsController, children: [
                      OverView(
                        state: detailsState,
                        duration: widget.duration,
                        schemeId:
                            detailsState.singleFundDetails.details.schemeId,
                      ),
                      AllocationView(
                        state: detailsState,
                        schemeId:
                            detailsState.singleFundDetails.details.schemeId,
                      ),
                      const PerformanceView(),
                      const FundInfoView()
                    ]),
                  )
                ],
              ),
            );
          }
          if (detailsState is DetailsError) {
            return Scaffold(
              body: Center(
                child: Text(detailsState.error),
              ),
            );
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
