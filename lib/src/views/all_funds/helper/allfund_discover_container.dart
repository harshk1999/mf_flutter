import 'package:flutter/material.dart';
import 'package:mf_app/src/views/all_funds/helper/custompainter_for_allfundscontainer.dart';
import 'package:mf_app/src/views/all_funds/helper/type_container.dart';

class DiscoverAllFundsContainer extends StatelessWidget {
  final String fundName;
  final String fundType;
  final String iconUrl;
  final String term;
  final String risk;
  final String oneYearReturn;
  final String threeYearReturn;
  final String fiveYearReturn;
  final String fundSize;
  final int fundRating;
  const DiscoverAllFundsContainer(
      {super.key,
      required this.fundName,
      required this.fundType,
      required this.term,
      required this.risk,
      required this.oneYearReturn,
      required this.threeYearReturn,
      required this.fiveYearReturn,
      required this.fundSize,
      required this.fundRating,
      required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12, left: 20, right: 20),
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                width: 1,
                color: const Color(0xffEFF1F5),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 8),
                    blurRadius: 15,
                    color: const Color(0xffE3E5EB).withOpacity(0.5))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 20),
                    child: Image.network(
                      iconUrl,
                      height: 35,
                      width: 35,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 48),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              fundName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Wrap(
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.end,
                            children: [
                              TypeContainer(text: fundType.toString()),
                              const SizedBox(
                                width: 8,
                              ),
                              TypeContainer(text: term),
                              const SizedBox(
                                width: 8,
                              ),
                              TypeContainer(text: risk),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 1,
                height: 1,
                color: Color(0xffEFF1F5),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, bottom: 12),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '1Y',
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
                            '$oneYearReturn %',
                            style: const TextStyle(
                                color: Color(0xff161719),
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '3Y',
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
                          '$threeYearReturn %',
                          style: const TextStyle(
                              color: Color(0xff161719),
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
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
                            '$fiveYearReturn %',
                            style: const TextStyle(
                                color: Color(0xff161719),
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          const Text(
                            'Fund size',
                            style: TextStyle(
                                color: Color(0xff7E838D),
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Text(
                              '$fundSize Cr',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color(0xff161719),
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Positioned(
          right: 18,
          top: 0,
          child: CustomContainerForAllFundsContainer(),
        ),
        Positioned(
          top: 10,
          right: 22,
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
                size: 14,
              )
            ],
          ),
        )
      ],
    );
  }
}
