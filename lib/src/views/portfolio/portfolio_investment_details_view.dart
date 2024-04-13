import 'package:flutter/material.dart';

class PortfolioInvestmentView extends StatefulWidget {
  const PortfolioInvestmentView({super.key});

  @override
  State<PortfolioInvestmentView> createState() =>
      _PortfolioInvestmentViewState();
}

class _PortfolioInvestmentViewState extends State<PortfolioInvestmentView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 2,
        shadowColor: const Color(0xffDCDEE5),
        backgroundColor: const Color(0xffFFFFFF),
        actions: [
          TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorColor: const Color(0xff3F4599),
              unselectedLabelColor: const Color(0xff5F6570),
              indicatorPadding:
                  const EdgeInsets.only(top: 16, right: 20, left: 20),
              tabs: const [
                Tab(
                  child: Text(
                    "Total Investment",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5f646f),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "In SMC",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5f646f),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  child: Text(
                    "External",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff5f646f),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
          const Spacer()
        ],
      ),
    );
  }
}
