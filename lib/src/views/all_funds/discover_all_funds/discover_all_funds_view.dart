import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/all_funds/discover_all_funds/discover_all_funds_view_model.dart';
import 'package:mf_app/src/views/all_funds/helper/allfund_discover_container.dart';
import 'package:mf_app/src/views/all_funds/helper/custombutton.dart';
import 'package:mf_app/src/views/all_funds/helper/rating_container.dart';
import 'package:mf_app/src/views/explore/explore_view.dart';
import 'package:provider/provider.dart';

class DiscoverAllFundsView extends StatefulWidget {
  const DiscoverAllFundsView({super.key});

  @override
  State<DiscoverAllFundsView> createState() => _DiscoverAllFundsViewState();
}

class _DiscoverAllFundsViewState extends State<DiscoverAllFundsView> {
  late final AllFundsViewModel afvm;
  late final ScrollController _scrollController;

  String? expanded;
  List<String> filterNamesForDropDown = [
    'Popularity',
    'Fund Size',
    '1Y Return',
    '3Y Return',
    '5Y Return'
  ];

  @override
  void initState() {
    super.initState();
    afvm = context.read<AllFundsViewModel>();
    afvm.initialise();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        afvm.loadMoreFunds();
      }
    });
    afvm.inititaliseBottomSheet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xffFFFFFF),
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.bottomNavBarHome);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(28),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Discover all funds",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Color(0xff161719)),
                  ),
                ),
                const Spacer(),
                ValueListenableBuilder(
                    valueListenable: afvm.toggleNotifier,
                    builder: (_, value, __) {
                      // String initialValue = afvm.getFilterNames().first;
                      return Container(
                        height: 33,
                        width: 116,
                        margin: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.5, color: const Color(0xffDDE0E7)),
                        ),
                        child: DropdownButton(
                            underline: const SizedBox(),
                            elevation: 0,
                            dropdownColor: const Color(0xffFFFFFF),
                            isExpanded: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff161719),
                            ),
                            value: value,
                            icon: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 8),
                              child: SvgPicture.asset(
                                  'assets/icons/svg/dropdown_arrow.svg'),
                            ),
                            items:
                                afvm.getFilterNames().map((String filterNames) {
                              return DropdownMenuItem(
                                  alignment: Alignment.bottomCenter,
                                  value: filterNames,
                                  child: Text(filterNames));
                            }).toList(),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                afvm.toggleFilterNames(newValue);
                              }
                            }),
                      );
                    })
              ],
            ),
          )),
      body: ValueListenableBuilder(
          valueListenable: afvm.allFundNotifier,
          builder: (_, allFundsState, __) {
            if (allFundsState is AllFundsError) {
              return Center(
                child: Text(allFundsState.error),
              );
            }

            if (allFundsState is AllFundsLoaded) {
              return Column(
                children: [
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 8),
                              blurRadius: 15,
                              color: const Color(0xffE3E5EB).withOpacity(0.5))
                        ]),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.justify,
                            cursorColor: const Color(0xff5F6570),
                            cursorHeight: 16,
                            decoration: InputDecoration(
                              fillColor: const Color(0xffFFFFFF),
                              filled: true,
                              prefixIconConstraints:
                                  const BoxConstraints(minWidth: 1),
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(top: 6, right: 12),
                                child: UnconstrainedBox(
                                  child: GestureDetector(
                                    child: SvgPicture.asset(
                                      'assets/icons/svg/search_icon2.svg',
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                ),
                              ),
                              hintText: 'Search mutual funds',
                              hintStyle: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              afvm.searchForAllFunds(value);
                            },
                          ),
                        ),
                        const Spacer(),
                        const Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: VerticalDivider(
                            thickness: 1,
                            color: Color(0xffEFF1F5),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: const Color(0xffFFFFFF),
                                isDismissible: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  List<bool> expansionStates = List.filled(
                                      afvm
                                          .getFilterNamesForBottomSheet()
                                          .length,
                                      false);

                                  return ValueListenableBuilder(
                                      valueListenable: afvm.filterNotifier,
                                      builder: (_, filtersState, __) {
                                        if (filtersState is! FilterlistLoaded) {
                                          return const SizedBox();
                                        }
                                        final List<FiltersEntity> filters =
                                            filtersState.filtersList;
                                        return StatefulBuilder(
                                            builder: (_, set) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            decoration: const BoxDecoration(
                                                color: Color(0xffFFFFFF),
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(20),
                                                )),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8,
                                            child: ValueListenableBuilder(
                                                valueListenable:
                                                    afvm.filterNotifier,
                                                builder: (_, __, ___) {
                                                  return Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 32),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                              'Filters',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            const Spacer(),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: const Icon(
                                                                Icons.close,
                                                                size: 28,
                                                                color: Color(
                                                                    0xff3F424C),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 34,
                                                      ),
                                                      Expanded(
                                                        child:
                                                            ListView.separated(
                                                          itemCount:
                                                              filters.length,
                                                          itemBuilder:
                                                              (_, topIndex) {
                                                            final FiltersEntity
                                                                cFilter =
                                                                filters[
                                                                    topIndex];

                                                            // return GestureDetector(
                                                            //   onTap: () {

                                                            //   },
                                                            //   // child: Row(
                                                            //   children: [
                                                            //     Text(
                                                            //       filterName,
                                                            //       style: const TextStyle(
                                                            //           fontFamily: 'Poppins',
                                                            //           fontWeight:
                                                            //               FontWeight.w600,
                                                            //           fontSize: 16,
                                                            //           color:
                                                            //               Color(0xff3F424C)),
                                                            //     ),
                                                            //     const Spacer(),
                                                            //     const Icon(Icons.add)
                                                            //   ],
                                                            // ),
                                                            // );
                                                            return Theme(
                                                              data: Theme.of(
                                                                      context)
                                                                  .copyWith(
                                                                      dividerColor:
                                                                          Colors
                                                                              .transparent),
                                                              child:
                                                                  ExpansionTile(
                                                                iconColor:
                                                                    const Color(
                                                                        0xff7E838D),

                                                                // collapsedIconColor:
                                                                //     const Color(
                                                                //         0xff7E838D),
                                                                // iconColor:
                                                                //     const Color(
                                                                //         0xff7E838D),
                                                                tilePadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                trailing: Icon(
                                                                  expansionStates[
                                                                          topIndex]
                                                                      ? Icons
                                                                          .remove
                                                                      : Icons
                                                                          .add,
                                                                  color: const Color(
                                                                      0xff7E838D),
                                                                ),
                                                                onExpansionChanged:
                                                                    (bool
                                                                        expanded) {
                                                                  set(() {
                                                                    expansionStates[
                                                                            topIndex] =
                                                                        expanded;
                                                                  });
                                                                },
                                                                title: Text(
                                                                  cFilter.name,
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          16,
                                                                      color: Color(
                                                                          0xff3F424C)),
                                                                ),

                                                                childrenPadding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                children: cFilter
                                                                        .isRating
                                                                    ? <Widget>[
                                                                        Row(
                                                                          children: List.generate(
                                                                              5,
                                                                              (index) {
                                                                            return RatingContainerForFilters(
                                                                              rating: index + 1,
                                                                              svg: 'assets/icons/svg/star.svg',
                                                                            );
                                                                          }),
                                                                        )
                                                                      ]
                                                                    : List
                                                                        .generate(
                                                                        cFilter
                                                                            .values
                                                                            .length,
                                                                        (index) {
                                                                          return Row(
                                                                            children: [
                                                                              Checkbox(
                                                                                checkColor: Colors.white,
                                                                                value: cFilter.selected.contains(cFilter.values[index].$1),
                                                                                onChanged: (_) {
                                                                                  afvm.onFilterTap(topIndex, index);
                                                                                },
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 16,
                                                                              ),
                                                                              Text(
                                                                                cFilter.values[index].$1,
                                                                                style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500, fontSize: 14, color: Color(0xff7E838D)),
                                                                              )
                                                                            ],
                                                                          );
                                                                        },
                                                                      ),
                                                              ),
                                                            );
                                                          },
                                                          separatorBuilder:
                                                              (_, int index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          6),
                                                              child: SvgPicture
                                                                  .asset(
                                                                      'assets/images/svg/dotted_lines.svg'),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 28),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () => afvm
                                                                    .clearFilter(),
                                                                child:
                                                                    const CustomButtonContainer(
                                                                        buttonName:
                                                                            Text(
                                                                          'Clear all',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color:
                                                                                Color(0xff3f4599),
                                                                          ),
                                                                        ),
                                                                        color: Color(
                                                                            0xffFFFFFF)),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 20,
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  afvm.onApply();
                                                                },
                                                                child:
                                                                    const CustomButtonContainer(
                                                                  buttonName:
                                                                      Text(
                                                                    'Apply',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Color(
                                                                          0xffFFFFFF),
                                                                    ),
                                                                  ),
                                                                  color: Color(
                                                                      0xff3f4599),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                }),
                                          );
                                        });
                                      });
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SvgPicture.asset(
                              'assets/icons/svg/filter.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        controller: _scrollController,
                        physics: const ClampingScrollPhysics(),
                        itemCount: allFundsState.fundInfoList.length,
                        itemBuilder: (_, index) {
                          final allFund = allFundsState.fundInfoList[index];
                          return GestureDetector(
                            key: ValueKey(allFund.schemeId),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.detailScreen,
                                  arguments: ExploreScreenArguments(
                                      schemeId: allFund.schemeId,
                                      duration: '6M'));
                            },
                            child: DiscoverAllFundsContainer(
                              fundName: allFund.name,
                              iconUrl: allFund.iconUrl,
                              fundType: allFund.category.toString(),
                              term: allFund.subCategory,
                              risk: allFund.riskType,
                              oneYearReturn:
                                  allFund.ret1Year.toStringAsFixed(2),
                              threeYearReturn:
                                  allFund.ret3Year.toStringAsFixed(2),
                              fiveYearReturn:
                                  allFund.ret5Year.toStringAsFixed(2),
                              fundSize: allFund.fundSize.toString(),
                              fundRating: allFund.fundRating,
                            ),
                          );
                        }),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
