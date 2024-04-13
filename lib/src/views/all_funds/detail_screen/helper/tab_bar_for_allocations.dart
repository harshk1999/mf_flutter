import 'package:flutter/material.dart';

class TabBarForAllocations extends StatelessWidget {
  const TabBarForAllocations({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      indicatorColor: Color(0xff3F4599),
      unselectedLabelColor: Color(0xff5f646f),
      isScrollable: true,
      labelColor: Color(0xff3F4599),
      indicatorPadding: EdgeInsets.only(top: 16),
      tabs: [
        Tab(
            child: Text(
          "Top Stock Holding",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        )),
        Text(
          "By Market Cap",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          "By Sectors",
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        )
      ],
    );
  }
}
