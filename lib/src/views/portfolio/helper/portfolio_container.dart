import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PortfolioContainer extends StatelessWidget {
  final int color1;
  final int color2;
  final String currentAmount;
  final String investedAmount;
  final String returns;
  final String oneDayReturn;
  final String oneDayReturnPercent;
  final String head;
  final double opacity1;
  final double opacity2;
  final int textColor;
  final int arrowColor;

  const PortfolioContainer(
      {super.key,
      required this.color1,
      required this.color2,
      required this.currentAmount,
      required this.investedAmount,
      required this.returns,
      required this.oneDayReturn,
      required this.oneDayReturnPercent,
      required this.head,
      required this.opacity1,
      required this.opacity2,
      required this.textColor,
      required this.arrowColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          height: 49,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(color1).withOpacity(opacity1),
                    Color(color2).withOpacity(opacity2)
                  ]),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              border: const Border.fromBorderSide(
                  BorderSide(width: 1, color: Color(0xffEFF1F5)))),
          child: Row(
            children: [
              Text(
                head,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(textColor),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_sharp,
                color: Color(arrowColor),
                size: 20,
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 15),
                  blurRadius: 15,
                  color: const Color(0xffDDE0E7).withOpacity(0.36))
            ],
            border: const Border.fromBorderSide(
                BorderSide(width: 1, color: Color(0xffEFF1F5))),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(12)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Current Amount',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5f646f),
                  height: 23 / 13,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 4),
                    child: SvgPicture.asset(
                      'assets/images/svg/rupee.svg',
                      height: 16,
                      width: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    currentAmount,
                    style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff161719),
                      height: 30 / 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                        color: Color(0xffEFF1F5),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: const Text(
                      "1D",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff5f646f),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SvgPicture.asset(
                      'assets/images/svg/rupee.svg',
                      height: 10,
                      width: 10,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      oneDayReturn,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff161719),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "($oneDayReturnPercent%)",
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff27aa6b),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Invested amount",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5f646f),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        investedAmount.toString(),
                        style: const TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff161719),
                          height: 20 / 13,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Returns",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff5f646f),
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            returns.toString(),
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff161719),
                            ),
                            textAlign: TextAlign.end,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            "($oneDayReturnPercent%)",
                            style: const TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff27aa6b),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
