import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TotalInvestmentWidget extends StatefulWidget {
  final int color1;
  final int color2;
  final int color3;
  final String heading;
  final String currentAmount;
  final String? oneDayReturn;
  final String? investedAmount;
  final String? returns;

  const TotalInvestmentWidget(
      {super.key,
      required this.color1,
      required this.color2,
      required this.color3,
      required this.heading,
      required this.currentAmount,
      this.oneDayReturn,
      this.investedAmount,
      this.returns});

  @override
  State<TotalInvestmentWidget> createState() => _TotalInvestmentWidgetState();
}

class _TotalInvestmentWidgetState extends State<TotalInvestmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              border: Border.all(color: Colors.grey),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(widget.color1), Color(widget.color2)],
              )),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(widget.heading,
                style: const TextStyle(
                    fontFamily: 'Poppins', fontSize: 16, color: Colors.white)),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color(widget.color3)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  'Current amount',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/svg/rupee.svg'),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      widget.currentAmount,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
