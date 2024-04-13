import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AboutFundManagerConatiners extends StatelessWidget {
  final String fundManagerName;
  final String imgUrl;

  const AboutFundManagerConatiners(
      {super.key, required this.fundManagerName, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          SvgPicture.asset(
            imgUrl,
            color: Color(0xffD9D9D9),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            fundManagerName,
            style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff161719),
              height: 21 / 14,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.add,
            size: 32,
          ),
        ],
      ),
    );
  }
}
