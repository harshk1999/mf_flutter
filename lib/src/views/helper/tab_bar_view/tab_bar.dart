import 'package:flutter/material.dart';
import 'package:mf_app/src/views/explore/explore_view_model.dart';
import 'package:provider/provider.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  late final ExploreViewModel evm;
  @override
  void initState() {
    super.initState();
    evm = context.read<ExploreViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
        indicatorPadding: const EdgeInsets.only(top: 16),
        isScrollable: true,
        labelColor: const Color(0xff3F4599),
        unselectedLabelColor: const Color(0xff7E838D),
        tabs: [
          Tab(
            child: Text(
              evm.categoryNameList[0],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Tab(
            child: Text(
              evm.categoryNameList[1],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Tab(
            child: Text(
              evm.categoryNameList[2],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Tab(
              child: Row(
            children: [
              Text(
                evm.categoryNameList[3],
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff19BC8A),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                  child: Text(
                    'Tax Saving',
                    style: TextStyle(color: Color(0xffFFFFFF), fontSize: 10),
                  ),
                ),
              )
            ],
          )),
          Tab(
            child: Text(
              evm.categoryNameList[4],
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ]);
  }
}
