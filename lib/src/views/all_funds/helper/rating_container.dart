import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RatingContainerForFilters extends StatelessWidget {
  final int rating;
  final String svg;
  const RatingContainerForFilters(
      {super.key, required this.rating, required this.svg});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 9),
      margin: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color(0xffF7F8FA),
      ),
      child: Row(children: [
        Text(
          rating.toString(),
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xff5F6570)),
        ),
        const SizedBox(
          width: 2,
        ),
        SvgPicture.asset(
          svg,
          height: 12,
          width: 12,
        ),
      ]),
    );
  }
}
