import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

class TopFundCard extends StatefulWidget {
  final String imgUrl;
  final String fundName;
  final double rating;
  final double cagr;
  const TopFundCard(
      {super.key,
      required this.imgUrl,
      required this.fundName,
      required this.rating,
      required this.cagr});

  @override
  State<TopFundCard> createState() => _TopFundCardState();
}

class _TopFundCardState extends State<TopFundCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      margin: const EdgeInsets.only(bottom: 24),
      width: 144,
      height: 174,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Color(0xffDCDEE5), blurRadius: 26, offset: Offset(0, 12))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Image.network(
            widget.imgUrl,
            height: 40,
            width: 40,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            widget.fundName,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 16,
          ),
          RatingBar(
              itemSize: 14,
              initialRating: widget.rating,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              ignoreGestures: true,
              ratingWidget: RatingWidget(
                  full: SvgPicture.asset(
                    'assets/icons/svg/star_full.svg',
                  ),
                  half: SvgPicture.asset(
                    'assets/icons/svg/half_star.svg',
                  ),
                  empty: SvgPicture.asset(
                    'assets/icons/svg/empty_star.svg',
                  )),
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              onRatingUpdate: (rating) {}),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                widget.cagr.toStringAsFixed(1),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                width: 4,
              ),
              const Text(
                '(3Y CAGR)',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
