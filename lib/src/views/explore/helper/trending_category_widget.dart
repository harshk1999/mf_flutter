import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TrendingCategoryWidget extends StatelessWidget {
  final String imgUrl;
  final String name;
  const TrendingCategoryWidget(
      {super.key, required this.imgUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          imgUrl,
          height: 32,
          width: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          name,
          textAlign: TextAlign.left,
          maxLines: 2,
          style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: Color(0xff161719)),
        )
      ],
    );
  }
}
