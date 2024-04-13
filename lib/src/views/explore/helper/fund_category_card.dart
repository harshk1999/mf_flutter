import 'package:flutter/material.dart';
import 'package:mf_app/src/views/explore/helper/custom_painter_for_rating.dart';

class FundCateogryCard extends StatelessWidget {
  final String fundIcon;
  final String fundName;
  final double cagr;
  // final int cagrYear;
  final double fundRating;
  const FundCateogryCard(
      {super.key,
      required this.fundIcon,
      required this.fundName,
      required this.cagr,
      // required this.cagrYear,
      required this.fundRating});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // height: 150,
          width: 144,
          padding: const EdgeInsets.only(left: 12, right: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.network(
                fundIcon,
                height: 36,
                width: 36,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                fundName,
                maxLines: 2,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Text(
                    '${cagr.toStringAsFixed(1)}%',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  const Text(
                    ('(3Y CAGR)'),
                    style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff7E838D),
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: CustomPaint(
            size: const Size(56, 21),
            painter: CustomPainterForRatingContainer(),
          ),
        ),
        Positioned(
          top: 2,
          right: 6,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                fundRating.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const Icon(
                Icons.star,
                color: Colors.white,
                size: 12,
              )
            ],
          ),
        )
      ],
    );
  }
}
