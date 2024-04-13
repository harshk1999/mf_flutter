import 'package:flutter/material.dart';
import 'package:mf_app/src/views/all_funds/helper/custompainter_for_allfundscontainer.dart';
import 'package:mf_app/src/views/all_funds/helper/type_container.dart';

class GoalPlanFundContainer extends StatelessWidget {
  final String fundName;
  final String fundType;
  final String fundIcon;
  final String term;
  final String fiveYearReturn;
  final String fundSize;
  final int fundRating;
  const GoalPlanFundContainer(
      {super.key,
      required this.fundName,
      required this.fundType,
      required this.fundIcon,
      required this.term,
      required this.fiveYearReturn,
      required this.fundSize,
      required this.fundRating});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(left: 16, right: 24, bottom: 24),
        // height: 160,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 1, color: const Color(0xffEFF1F5)),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 8),
                  blurRadius: 15,
                  color: const Color(0xffE3E5EB).withOpacity(0.5))
            ]),
        child: Column(children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 11, left: 16, top: 26),
                child: Image.network(
                  fundIcon,
                  height: 35,
                  width: 35,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: Text(
                      fundName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      TypeContainer(text: fundType),
                      const SizedBox(
                        width: 8,
                      ),
                      TypeContainer(text: term),
                    ],
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 1,
            height: 1,
            color: Color(0xffEFF1F5),
          ),
          const SizedBox(
            height: 11,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '5Y',
                      style: TextStyle(
                          color: Color(0xff7E838D),
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      fiveYearReturn,
                      style: const TextStyle(
                          color: Color(0xff161719),
                          fontFamily: 'Poppins',
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fund size',
                    style: TextStyle(
                        color: Color(0xff7E838D),
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    fundSize,
                    style: const TextStyle(
                        color: Color(0xff161719),
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                // margin: const EdgeInsets.only(right: 24),
                height: 42,
                width: 108,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(width: 1, color: const Color(0xff3F4599)),
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: const Text(
                  'Invest Now',
                  style: TextStyle(
                      color: Color(0xff3F4599),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400),
                ),
              )
            ],
          ),
        ]),
      ),
      const Positioned(
        right: 0,
        top: 0,
        child: CustomContainerForAllFundsContainer(),
      ),
      Positioned(
        top: 8,
        right: 12,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              fundRating.toString(),
              style: const TextStyle(
                  color: Color(0xff3F4599),
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
            const Icon(
              Icons.star,
              color: Color(0xff3F4599),
              size: 13,
            )
          ],
        ),
      )
    ]);
  }
}
