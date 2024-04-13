import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/app/themes/themes.dart';
import 'package:mf_app/src/views/Login/otp/otp_view_model.dart';
import 'package:mf_app/src/views/bottom_nav_bar/bottom_nav_bar_view_model.dart';
import 'package:mf_app/src/views/explore/explore_view.dart';
import 'package:mf_app/src/views/portfolio/portfolio_view.dart';
import 'package:mf_app/src/views/watchlist/watchlist_view.dart';
import 'package:provider/provider.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  late final BottomNavBarViewModel bnbvm;
  int index = 0;
  @override
  void initState() {
    super.initState();
    bnbvm = context.read<BottomNavBarViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: AppTheme.primaryColor,
        toolbarHeight: 81,
        title: SvgPicture.asset(
          'assets/icons/svg/smc_icon.svg',
          height: 36,
          width: 100,
        ),
        actions: [
          GestureDetector(
              onTap: () {},
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.searchScreen);
                  },
                  child: SvgPicture.asset('assets/icons/svg/search_icon.svg'))),
          const SizedBox(width: 16),
          SvgPicture.asset('assets/icons/svg/bell_icon.svg'),
          const SizedBox(width: 16),
          GestureDetector(
              onTap: () {
                Provider.of<OTPViewModel>(context, listen: false).logoutUser();
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.loginScreen);
              },
              child:
                  SvgPicture.asset('assets/icons/svg/profile_icon_appBar.svg')),
          const SizedBox(width: 20),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: bnbvm.indexNotifier,
          builder: (_, indexN, __) {
            return BottomNavigationBar(
                currentIndex: indexN,
                onTap: (int newindex) {
                  bnbvm.navigate(newindex);
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedIconTheme:
                    const IconThemeData(color: Color((0xff3F4599))),
                items: [
                  BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                          'assets/icons/svg/explore_actiive.svg'),
                      icon:
                          SvgPicture.asset('assets/icons/svg/explore_icon.svg'),
                      label: 'Explore'),
                  BottomNavigationBarItem(
                      activeIcon: SvgPicture.asset(
                          'assets/icons/svg/portfolio_active.svg'),
                      icon: SvgPicture.asset(
                          'assets/icons/svg/portfolio_icon.svg'),
                      label: 'Portfolio'),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                          'assets/icons/svg/watchlist_icon.svg'),
                      label: 'Watchlist'),
                ]);
          }),
      body: ValueListenableBuilder(
          valueListenable: bnbvm.indexNotifier,
          builder: (_, indexN, __) {
            return IndexedStack(
              index: indexN,
              children: const [
                ExploreView(),
                PortfolioNavigator(),
                WatchListView(),
              ],
            );
          }),
    );
  }
}
