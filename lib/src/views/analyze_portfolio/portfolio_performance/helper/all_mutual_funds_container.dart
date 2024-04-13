import 'package:flutter/material.dart';

class AllMutualFundsContainer extends StatelessWidget {
  final String iconUrl;
  final String fundName;
  final String currentAmount;
  final String invstAmount;
  final String returnXirr;
  const AllMutualFundsContainer(
      {super.key,
      required this.iconUrl,
      required this.fundName,
      required this.currentAmount,
      required this.invstAmount,
      required this.returnXirr});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: const Color(0xffEFF1F5)),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 15,
                color: const Color(0xffE3E5EB).withOpacity(0.5))
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 16,
            // ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    iconUrl,
                    height: 35,
                    width: 37,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 9,
                  child: Text(
                    fundName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              thickness: 1,
              color: Color(0xffEFF1F5),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current amount',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5F6570)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '₹$currentAmount',
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Invested amount',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5F6570)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '₹$invstAmount',
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Return (XIRR)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff5F6570)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '$returnXirr%',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff27AA6B)),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
