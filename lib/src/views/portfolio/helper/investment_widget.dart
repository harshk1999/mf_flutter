import 'package:flutter/material.dart';

class PortfolioInvestmentWidget extends StatefulWidget {
  const PortfolioInvestmentWidget({super.key});

  @override
  State<PortfolioInvestmentWidget> createState() =>
      _PortfolioInvestmentWidgetState();
}

class _PortfolioInvestmentWidgetState extends State<PortfolioInvestmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 173,
          decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: const Color(0xffEFF1F5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 15),
                    blurRadius: 30,
                    color: const Color(0xffDDE0E7).withOpacity(0.36))
              ]),
          child: const Column(
            children: [
              Row(
                children: [
                  Text(
                    "Your investments",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff161719),
                      height: 30 / 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    width: 6,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
