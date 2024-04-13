import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mf_app/src/views/all_funds/detail_screen/detail_view_model.dart';
import 'package:provider/provider.dart';

class AllocationView extends StatefulWidget {
  final int schemeId;
  final DetailsLoaded state;
  const AllocationView(
      {super.key, required this.schemeId, required this.state});

  @override
  State<AllocationView> createState() => _AllocationViewState();
}

class _AllocationViewState extends State<AllocationView>
    with TickerProviderStateMixin {
  late final DetailsViewModel dvm;
  late DetailsLoaded allocationState;
  late int selectedIndex;
  late TabController _allocationTabController;
  late TabController _allocationTabControllerfoo;
  late final List<Color> colorsList;
  // late final

  @override
  void didUpdateWidget(AllocationView oldWidget) {
    super.didUpdateWidget(oldWidget);
    allocationState = widget.state;
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    dvm = context.read<DetailsViewModel>();
    allocationState = widget.state;
    _allocationTabController = TabController(length: 3, vsync: this);
    _allocationTabControllerfoo = TabController(length: 3, vsync: this);
    colorsList = const [
      Color(0xff3D63EA),
      Color(0xff4CD1E4),
      Color(0xffFF834E),
      Color(0xffFFC961),
      Color(0xff4EAAFF),
      Color(0xff9D63FF),
    ];
  }

  String removeUnderscoresAndCapitalize(String text) {
    List<String> words = text.split('_');
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }
    return words.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 28),
                    decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? const Color(0xff3D63EA)
                            : const Color(0xffEFF1F5),
                        boxShadow: [
                          if (selectedIndex == 0)
                            const BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 15,
                                color: Color(0xffDBDDE3))
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Text(
                      'Equity',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              selectedIndex == 0 ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 28),
                    decoration: BoxDecoration(
                        color: selectedIndex == 1
                            ? const Color(0xff3D63EA)
                            : const Color(0xffEFF1F5),
                        boxShadow: [
                          if (selectedIndex == 1)
                            const BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 15,
                                color: Color(0xffDBDDE3))
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Text(
                      'Debt',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              selectedIndex == 1 ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 28),
                    decoration: BoxDecoration(
                        color: selectedIndex == 2
                            ? const Color(0xff3D63EA)
                            : const Color(0xffEFF1F5),
                        boxShadow: [
                          if (selectedIndex == 2)
                            const BoxShadow(
                                offset: Offset(0, 8),
                                blurRadius: 15,
                                color: Color(0xffDBDDE3))
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                    child: Text(
                      'Other',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color:
                              selectedIndex == 2 ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          // if (isSelectedList[0])
          //   const TabBar(tabs: [
          //     Tab(
          //       text: '1',
          //     ),
          //     Tab(
          //       text: '2',
          //     ),
          //     Tab(
          //       text: '3',
          //     )
          //   ]),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.5,
          //   child: TabBarView(children: [
          //     PieChartViewWidget(
          //         pieChartSectionDataList: [],
          //         allocationList: [],
          //         colorsList: [],
          //         name: '',
          //         percentage: 0,
          //         allocationName: ''),
          //     PieChartViewWidget(
          //         pieChartSectionDataList: [],
          //         allocationList: [],
          //         colorsList: [],
          //         name: '',
          //         percentage: 0,
          //         allocationName: ''),
          //     PieChartViewWidget(
          //         pieChartSectionDataList: [],
          //         allocationList: [],
          //         colorsList: [],
          //         name: '',
          //         percentage: 0,
          //         allocationName: '')
          //   ]),
          // )

          if (allocationState.compositionList[0].name == 'EQUITY' &&
              selectedIndex == 0)
            TabBar(
                controller: _allocationTabController,
                unselectedLabelColor: const Color(0xff5F6570),
                labelColor: const Color(0xff3F4599),
                indicatorColor: const Color(0xff3F4599),
                tabs: [
                  Tab(
                    child: Text(
                      removeUnderscoresAndCapitalize(allocationState
                          .compositionList[0].categories[0].name),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'By ${removeUnderscoresAndCapitalize(allocationState.compositionList[0].categories[1].name)}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      removeUnderscoresAndCapitalize(allocationState
                          .compositionList[0].categories[2].name),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  )
                ]),

          if (allocationState.compositionList[0].name == 'EQUITY' &&
              selectedIndex == 0)
            Expanded(
              child:
                  TabBarView(controller: _allocationTabController, children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 190, child: PieChart(PieChartData())),
                      const SizedBox(
                        height: 24,
                      ),
                      allocationState.compositionList[0].categories[0]
                              .allocations.isEmpty
                          ? const SizedBox(
                              height: 190,
                            )
                          : Column(
                              children: List.generate(
                                  allocationState
                                              .compositionList[0]
                                              .categories[0]
                                              .allocations
                                              .length <=
                                          6
                                      ? allocationState.compositionList[0]
                                          .categories[0].allocations.length
                                      : 6, (index) {
                                final allocations = allocationState
                                    .compositionList[0]
                                    .categories[0]
                                    .allocations[index];

                                return Row(
                                  children: [
                                    Container(
                                      height: 22,
                                      width: 5,
                                      decoration: const BoxDecoration(
                                          color: Color(0xff3D63EA),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(2.5))),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      allocations.name,
                                      style: const TextStyle(
                                          color: Color(0xff7E838D),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    const Spacer(),
                                    Text(
                                        '${allocations.percentage.toStringAsFixed(2)} %',
                                        style: const TextStyle(
                                            color: Color(0xff161719),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16)),
                                  ],
                                );
                              }),
                            )
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 190, child: PieChart(PieChartData())),
                    const SizedBox(
                      height: 24,
                    ),
                    allocationState.compositionList[0].categories[1].allocations
                            .isEmpty
                        ? const SizedBox(
                            height: 190,
                          )
                        : Column(
                            children: List.generate(
                                allocationState.compositionList[0].categories[1]
                                            .allocations.length <=
                                        6
                                    ? allocationState.compositionList[0]
                                        .categories[1].allocations.length
                                    : 6, (index) {
                              final allocations = allocationState
                                  .compositionList[0]
                                  .categories[1]
                                  .allocations[index];

                              return Row(
                                children: [
                                  Container(
                                    height: 22,
                                    width: 5,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff3D63EA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.5))),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    allocations.name,
                                    style: const TextStyle(
                                        color: Color(0xff7E838D),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  const Spacer(),
                                  Text(
                                      '${allocations.percentage.toStringAsFixed(2)} %',
                                      style: const TextStyle(
                                          color: Color(0xff161719),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                ],
                              );
                            }),
                          )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 190, child: PieChart(PieChartData())),
                    const SizedBox(
                      height: 24,
                    ),
                    allocationState.compositionList[0].categories[2].allocations
                            .isEmpty
                        ? const SizedBox(
                            height: 190,
                          )
                        : Column(
                            children: List.generate(
                                allocationState.compositionList[0].categories[2]
                                            .allocations.length <=
                                        6
                                    ? allocationState.compositionList[0]
                                        .categories[2].allocations.length
                                    : 6,
                                growable: true, (index) {
                              final allocations = allocationState
                                  .compositionList[0]
                                  .categories[2]
                                  .allocations[index];

                              return Row(
                                children: [
                                  Container(
                                    height: 22,
                                    width: 5,
                                    decoration: const BoxDecoration(
                                        color: Color(0xff3D63EA),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(2.5))),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    allocations.name,
                                    style: const TextStyle(
                                        color: Color(0xff7E838D),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                  const Spacer(),
                                  Text(
                                      '${allocations.percentage.toStringAsFixed(2)} %',
                                      style: const TextStyle(
                                          color: Color(0xff161719),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                ],
                              );
                            }),
                          )
                  ],
                ),
              ]),
            ),

          if (allocationState.compositionList[1].name == 'DEBT' &&
              selectedIndex == 1)
            TabBar(
                // tabAlignment: TabAlignment.start,
                isScrollable: false,
                controller: _allocationTabControllerfoo,
                unselectedLabelColor: const Color(0xff5F6570),
                labelColor: const Color(0xff3F4599),
                indicatorColor: const Color(0xff3F4599),
                tabs: [
                  Tab(
                    child: Text(
                      removeUnderscoresAndCapitalize(allocationState
                          .compositionList[1].categories[0].name),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'By ${removeUnderscoresAndCapitalize(allocationState.compositionList[1].categories[1].name)}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      removeUnderscoresAndCapitalize(allocationState
                          .compositionList[1].categories[2].name),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  )
                ]),
          if (allocationState.compositionList[1].name == 'DEBT' &&
              selectedIndex == 1)
            Expanded(
              child: TabBarView(
                  controller: _allocationTabControllerfoo,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                              height: 190, child: PieChart(PieChartData())),
                          const SizedBox(
                            height: 24,
                          ),
                          allocationState.compositionList[1].categories[0]
                                  .allocations.isEmpty
                              ? const SizedBox(
                                  height: 190,
                                )
                              : Column(
                                  children: List.generate(
                                      allocationState
                                                  .compositionList[1]
                                                  .categories[0]
                                                  .allocations
                                                  .length <=
                                              6
                                          ? allocationState.compositionList[0]
                                              .categories[0].allocations.length
                                          : 6, (index) {
                                    final allocations = allocationState
                                        .compositionList[1]
                                        .categories[0]
                                        .allocations[index];

                                    return Row(
                                      children: [
                                        Container(
                                          height: 22,
                                          width: 5,
                                          decoration: const BoxDecoration(
                                              color: Color(0xff3D63EA),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2.5))),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          allocations.name,
                                          style: const TextStyle(
                                              color: Color(0xff7E838D),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        const Spacer(),
                                        Text(
                                            '${allocations.percentage.toStringAsFixed(2)} %',
                                            style: const TextStyle(
                                                color: Color(0xff161719),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16)),
                                      ],
                                    );
                                  }),
                                )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                              height: 190, child: PieChart(PieChartData())),
                          const SizedBox(
                            height: 24,
                          ),
                          allocationState.compositionList[1].categories[1]
                                  .allocations.isEmpty
                              ? const SizedBox(
                                  height: 190,
                                )
                              : Column(
                                  children: List.generate(
                                      allocationState
                                                  .compositionList[1]
                                                  .categories[1]
                                                  .allocations
                                                  .length <=
                                              6
                                          ? allocationState.compositionList[1]
                                              .categories[1].allocations.length
                                          : 6, (index) {
                                    final allocations = allocationState
                                        .compositionList[1]
                                        .categories[1]
                                        .allocations[index];

                                    return Row(
                                      children: [
                                        Container(
                                          height: 22,
                                          width: 5,
                                          decoration: const BoxDecoration(
                                              color: Color(0xff3D63EA),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2.5))),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          allocations.name,
                                          style: const TextStyle(
                                              color: Color(0xff7E838D),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        const Spacer(),
                                        Text(
                                            '${allocations.percentage.toStringAsFixed(2)} %',
                                            style: const TextStyle(
                                                color: Color(0xff161719),
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16)),
                                      ],
                                    );
                                  }),
                                )
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: 190, child: PieChart(PieChartData())),
                        const SizedBox(
                          height: 24,
                        ),
                        allocationState.compositionList[1].categories[2]
                                .allocations.isEmpty
                            ? const SizedBox(
                                height: 190,
                              )
                            : Column(
                                children: List.generate(
                                    allocationState
                                                .compositionList[1]
                                                .categories[2]
                                                .allocations
                                                .length <=
                                            6
                                        ? allocationState.compositionList[1]
                                            .categories[2].allocations.length
                                        : 6, (index) {
                                  final allocations = allocationState
                                      .compositionList[1]
                                      .categories[2]
                                      .allocations[index];

                                  return Row(
                                    children: [
                                      Container(
                                        height: 22,
                                        width: 5,
                                        decoration: const BoxDecoration(
                                            color: Color(0xff3D63EA),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.5))),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        allocations.name,
                                        style: const TextStyle(
                                            color: Color(0xff7E838D),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14),
                                      ),
                                      const Spacer(),
                                      Text(
                                          '${allocations.percentage.toStringAsFixed(2)} %',
                                          style: const TextStyle(
                                              color: Color(0xff161719),
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16)),
                                    ],
                                  );
                                }),
                              )
                      ],
                    ),
                  ]),
            )
        ],
      ),
    );
  }
}
