import 'package:flutter/material.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/portfolio/helper/portfolio_container.dart';
import 'package:mf_app/src/views/portfolio/portfolio_investment_details_view.dart';

class PortfolioNavigator extends StatefulWidget {
  static const initial = "/";
  static const piv = "piv";

  const PortfolioNavigator({super.key});

  @override
  State<PortfolioNavigator> createState() => _PortfolioNavigatorState();
}

class _PortfolioNavigatorState extends State<PortfolioNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        if (settings.name == PortfolioNavigator.piv) {
          return MaterialPageRoute(builder: (context) {
            return const PortfolioInvestmentView();
          });
        }
        return MaterialPageRoute(builder: (context) {
          return const PortfolioView();
        });
      },
      initialRoute: PortfolioNavigator.initial,
    );
  }
}

class PortfolioView extends StatefulWidget {
  const PortfolioView({super.key});

  @override
  State<PortfolioView> createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.portfolioInvestmentView);
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 12),
              child: PortfolioContainer(
                color1: 0xff3A48BC,
                color2: 0xff2A9D92,
                currentAmount: '12,500.00',
                investedAmount: '10000.00',
                returns: '2500.00',
                oneDayReturn: '25.00',
                oneDayReturnPercent: '0.25',
                head: 'Total Investment',
                opacity1: 1,
                opacity2: 1,
                textColor: 0xffFFFFFF,
                arrowColor: 0xffFFFFFF,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.portfolioInvestmentView);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: PortfolioContainer(
                color1: 0xff3A48BC,
                color2: 0xff2A9D92,
                currentAmount: '7,500.00',
                investedAmount: '10000.00',
                returns: '2500.00',
                oneDayReturn: '25.00',
                oneDayReturnPercent: '0.25',
                head: 'In SMC',
                opacity1: 0.2,
                opacity2: 0.2,
                textColor: 0xff161719,
                arrowColor: 0xff161719,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.portfolioInvestmentView);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: PortfolioContainer(
                color1: 0xff3A48BC,
                color2: 0xff2A9D92,
                currentAmount: '5000.00',
                investedAmount: '10000.00',
                returns: '2500.00',
                oneDayReturn: '25.00',
                oneDayReturnPercent: '0.25',
                head: 'External',
                opacity1: 0.15,
                opacity2: 0.15,
                textColor: 0xff161719,
                arrowColor: 0xff161719,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
