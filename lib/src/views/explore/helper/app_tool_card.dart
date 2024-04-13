import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExploreToolCard extends StatelessWidget {
  final String imgLink;
  final String name;
  const ExploreToolCard({super.key, required this.imgLink, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.2),
          boxShadow: [
            BoxShadow(
                color: const Color(0xffDCDEE5).withOpacity(0.6),
                blurRadius: 15,
                offset: const Offset(0, 8))
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Expanded(flex: 8, child: SvgPicture.asset(imgLink)),
          // const SizedBox(height: 8),
          Expanded(
            flex: 6,
            child: Text(
              name,
              maxLines: 2,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ),
          // const SizedBox(
          //   height: 16,
          // )
        ],
      ),
    );
  }
}
