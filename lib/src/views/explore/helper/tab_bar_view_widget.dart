import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mf_app/src/app/repository/models/explore_models/popular_funds_in_category_model.dart';
// import 'package:mf_app/src/app/repository/models/explore_models/trending_category_model.dart';
import 'package:mf_app/src/views/explore/helper/fund_category_card.dart';
import 'package:mf_app/src/views/explore/helper/trending_category_widget.dart';

class TabBarViewWidget extends StatefulWidget {
  final String type;
  final ValueChanged<int>? onTapList1;
  final ValueChanged<int>? onTapList2;
  final VoidCallback? onViewAll;
  final List<PopularFund> popularFunds;
  final List<TrendingCategory> trendingCategories;
  const TabBarViewWidget(
      {super.key,
      required this.type,
      this.onTapList1,
      this.onTapList2,
      this.onViewAll,
      required this.popularFunds,
      required this.trendingCategories});

  @override
  State<TabBarViewWidget> createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          if (widget.popularFunds.isNotEmpty)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 28, bottom: 32),
                  child: Text(
                    "Popular Funds in ${widget.type}",
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color(0xff161719)),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: widget.onViewAll,
                        child: const Text(
                          'View more',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xff3F4599),
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      SvgPicture.asset('assets/images/svg/arrow.svg')
                    ],
                  ),
                ),
              ],
            ),
          if (widget.popularFunds.isNotEmpty)
            SizedBox(
              height: 160,
              child: ListView.builder(
                // padding: const EdgeInsets.only(left: 16),
                // separatorBuilder: (_, index) {
                //   return const SizedBox(
                //     width: 16,
                //   );
                // },
                scrollDirection: Axis.horizontal,
                itemCount: widget.popularFunds.length,
                itemBuilder: (__, index) {
                  final popularFund = widget.popularFunds[index];
                  EdgeInsets padding =
                      const EdgeInsets.symmetric(horizontal: 16.0);
                  if (index == 0) {
                    padding = const EdgeInsets.only(left: 20.0, right: 8.0);
                  } else if (index == widget.popularFunds.length - 1) {
                    padding = const EdgeInsets.only(left: 8.0, right: 20.0);
                  } else {
                    padding = const EdgeInsets.symmetric(horizontal: 10.0);
                  }
                  return Padding(
                    padding: padding,
                    child: GestureDetector(
                      onTap: () {
                        widget.onTapList1!(popularFund.schemeId);
                      },
                      child: FundCateogryCard(
                          fundIcon: popularFund.iconUrl,
                          fundName: popularFund.name,
                          cagr: popularFund.returns,
                          fundRating: popularFund.rating.toDouble()),
                    ),
                  );
                },
              ),
            ),
          const SizedBox(
            height: 28,
          ),
          if (widget.trendingCategories.isNotEmpty)
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "Trending Categories in ${widget.type}",
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff161719)),
                  ),
                ),
                const Spacer(),
              ],
            ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemCount: widget.trendingCategories.length,
                itemBuilder: (_, index) {
                  final trendingCategory = widget.trendingCategories[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TrendingCategoryWidget(
                        imgUrl: trendingCategory.icon,
                        name: trendingCategory.name),
                  );
                }),
          )
        ],
      ),
    );
  }
}
