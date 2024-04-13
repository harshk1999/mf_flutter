import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ApScreenBar extends StatelessWidget {
  const ApScreenBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset('assets/images/svg/analyze_portfolio_new.svg'),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Analyze your Portfolio',
            style: TextStyle(
                color: Color(0xff3F4599),
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins'),
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Analyze your portfolios performance, evaluate health, and optimize for informed decisions',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff5F6570),
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: 'Poppins',
                height: 1.4),
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}
