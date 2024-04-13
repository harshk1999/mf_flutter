import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DiscoverButton extends StatelessWidget {
  const DiscoverButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      // height: 54,
      decoration: BoxDecoration(
          color: const Color(0xff3F4599),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                blurRadius: 15,
                spreadRadius: 0,
                color: const Color(0xff3F4599).withOpacity(0.39),
                offset: const Offset(0, 8))
          ]),
      child: Row(
        children: [
          const Spacer(),
          const Text(
            "Let's Discover all funds",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xffFFFFFF), fontSize: 14, fontFamily: "Poppins"),
          ),
          const Spacer(),
          SvgPicture.asset(
            'assets/icons/svg/white_arrow.svg',
            height: 12,
            width: 16,
          )
        ],
      ),
    );
  }
}
