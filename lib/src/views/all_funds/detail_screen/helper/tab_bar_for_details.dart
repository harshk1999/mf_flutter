import 'package:flutter/material.dart';

class TabBarForDetails extends StatefulWidget {
  final TabController controller;
  const TabBarForDetails({super.key, required this.controller});

  @override
  State<TabBarForDetails> createState() => _TabBarForDetailsState();
}

class _TabBarForDetailsState extends State<TabBarForDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 8),
            blurRadius: 15,
            color: const Color(0xffE3E5EB).withOpacity(0.5))
      ]),
      child: TabBar(
        controller: widget.controller,
        indicatorPadding: EdgeInsets.only(top: 16, right: 20, left: 20),
        indicatorColor: Color(0xff3F4599),
        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: true,
        labelColor: Color(0xff3F4599),
        unselectedLabelColor: Color(0xff5f646f),
        tabs: [
          Tab(
            child: Text(
              'Overview',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Allocation',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Performance',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Tab(
            child: Text(
              'Fund Info',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
