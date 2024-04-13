import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReturnCalculatorView extends StatefulWidget {
  const ReturnCalculatorView({super.key});

  @override
  State<ReturnCalculatorView> createState() => _ReturnCalculatorViewState();
}

class _ReturnCalculatorViewState extends State<ReturnCalculatorView> {
  late final TextEditingController howMuchToInvestController;
  late final TextEditingController expectedReturnController;
  late final TextEditingController timePeriodController;
  double howMuchToInvestSlider = 25000;
  double expectedAnnualReturnSlider = 12;
  double timePeriodSlider = 10;
  late double expectedReturns;
  late double totalInvestments;
  late double totalValue;
  @override
  void initState() {
    super.initState();
    howMuchToInvestController = TextEditingController(text: 25000.toString());
    expectedReturnController = TextEditingController(text: 12.toString());
    timePeriodController = TextEditingController(text: 10.toString());
    final (first, second, third) = calculateForSip(
        double.parse(howMuchToInvestController.text),
        double.parse(expectedReturnController.text),
        double.parse(timePeriodController.text));
    expectedReturns = first;
    totalInvestments = second;
    totalValue = third;
  }

  @override
  void dispose() {
    super.dispose();
    howMuchToInvestController.dispose();
    expectedReturnController.dispose();
    timePeriodController.dispose();
  }

  (double, double, double) calculateForSip(
      double investment, double expectedAnnualReturn, double timePeriod) {
    expectedAnnualReturn = expectedAnnualReturn / 100 / 12;
    double expectedReturns = investment *
            ((pow(1 + expectedAnnualReturn, timePeriod * 12) - 1) /
                expectedAnnualReturn) *
            (1 + expectedAnnualReturn) -
        investment * timePeriod * 12;
    double totalInvestment = investment * timePeriod * 12;
    double totalValue = expectedReturns + totalInvestment;

    return (expectedReturns, totalInvestment, totalValue);
  }

  (double, double, double) calculateForLumpSum(
      double investment, double expectedAnnualReturn, double timePeriod) {
    expectedAnnualReturn = expectedAnnualReturn / 100 / 12;
    double expectedReturns =
        investment * pow(1 + expectedAnnualReturn / 100, timePeriod) -
            investment;

    double totalInvestment = investment;

    double totalValue = expectedReturns + totalInvestment;

    return (totalValue, investment, expectedReturns);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Return Calculator',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      color: Color(0xffF7F8FA)),
                  child: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                              color: const Color(0xffDEE0E8).withOpacity(0.5)),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4))),
                    tabs: const [
                      Tab(
                        child: Text(
                          'SIP Monthly',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'LUMPSUM',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'How much you want to invest (₹)',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Container(
                                  height: 32,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xffDDE0E7))),
                                  child: TextField(
                                    controller: howMuchToInvestController,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.5, vertical: 4),
                                        border: InputBorder.none,
                                        isDense: true),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay),
                            child: Slider(
                              value: howMuchToInvestSlider,
                              max: 100000,
                              min: 500,
                              onChanged: (value) {
                                setState(() {
                                  howMuchToInvestSlider = value;
                                  howMuchToInvestController.text =
                                      value.toStringAsFixed(0);
                                });
                              },
                              activeColor: const Color(0xff19BC8A),
                              inactiveColor: const Color(0xffEFF1F5),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Expected Annual return (%)',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Container(
                                  height: 32,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xffDDE0E7))),
                                  child: TextField(
                                    controller: expectedReturnController,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.5, vertical: 4),
                                        border: InputBorder.none,
                                        isDense: true),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay),
                            child: Slider(
                              value: expectedAnnualReturnSlider,
                              max: 50,
                              min: 1,
                              onChanged: (value) {
                                setState(() {
                                  expectedAnnualReturnSlider = value;
                                  expectedReturnController.text =
                                      value.toStringAsFixed(0);
                                });
                              },
                              activeColor: const Color(0xff19BC8A),
                              inactiveColor: const Color(0xffEFF1F5),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              const Text(
                                'TIME PERIOD(IN YEAR)',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Container(
                                  height: 32,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xffDDE0E7))),
                                  child: TextField(
                                    controller: timePeriodController,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.5, vertical: 4),
                                        border: InputBorder.none,
                                        isDense: true),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay),
                            child: Slider(
                              value: timePeriodSlider,
                              max: 40,
                              min: 1,
                              onChanged: (value) {
                                setState(() {
                                  timePeriodSlider = value;
                                  timePeriodController.text =
                                      value.toStringAsFixed(0);
                                });
                              },
                              activeColor: const Color(0xff19BC8A),
                              inactiveColor: const Color(0xffEFF1F5),
                            ),
                          ),
                          const SizedBox(
                            height: 42,
                          ),
                          GestureDetector(
                            onTap: () {
                              final (first, second, third) = calculateForSip(
                                  double.parse(howMuchToInvestController.text),
                                  double.parse(expectedReturnController.text),
                                  double.parse(timePeriodController.text));
                              setState(() {
                                expectedReturns = first;
                                totalInvestments = second;
                                totalValue = third;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: const BoxDecoration(
                                  color: Color(0xff3F4599),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: const Center(
                                child: Text(
                                  'Calculate',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                color:
                                    const Color(0xff20BE8D).withOpacity(0.15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Total Value',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      Text(
                                        totalValue.toStringAsFixed(2),
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Your Investment',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹ $totalInvestments',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Expected Returns',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹ ${expectedReturns.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                color:
                                    const Color(0xff4E57CD).withOpacity(0.15)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/svg/i2.svg'),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      'Risk and Return Fundamentals',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xff3F4599),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  'Risk is the uncertainty in investment returns or the variability of returns linked to an asset.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  'Return is the net gain or loss on an investment, calculated by adding cash distributions and value change, then dividing by the initial investment.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'How much you want to invest (₹)',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Container(
                                  height: 32,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xffDDE0E7))),
                                  child: TextField(
                                    controller: howMuchToInvestController,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.5, vertical: 4),
                                        border: InputBorder.none,
                                        isDense: true),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay),
                            child: Slider(
                              value: howMuchToInvestSlider,
                              max: 100000,
                              onChanged: (value) {
                                setState(() {
                                  howMuchToInvestSlider = value;
                                  howMuchToInvestController.text =
                                      value.toStringAsFixed(0);
                                });
                              },
                              activeColor: const Color(0xff19BC8A),
                              inactiveColor: const Color(0xffEFF1F5),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Expected Annual return (%)',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Container(
                                  height: 32,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xffDDE0E7))),
                                  child: TextField(
                                    controller: expectedReturnController,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.5, vertical: 4),
                                        border: InputBorder.none,
                                        isDense: true),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay),
                            child: Slider(
                              value: expectedAnnualReturnSlider,
                              min: 1,
                              max: 50,
                              onChanged: (value) {
                                setState(() {
                                  expectedAnnualReturnSlider = value;
                                  expectedReturnController.text =
                                      value.toStringAsFixed(0);
                                });
                              },
                              activeColor: const Color(0xff19BC8A),
                              inactiveColor: const Color(0xffEFF1F5),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              const Text(
                                'TIME PERIOD(IN YEAR)',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const Spacer(),
                              Container(
                                  height: 32,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4)),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color(0xffDDE0E7))),
                                  child: TextField(
                                    controller: timePeriodController,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Colors.black),
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.5, vertical: 4),
                                        border: InputBorder.none,
                                        isDense: true),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                                overlayShape: SliderComponentShape.noOverlay),
                            child: Slider(
                              value: timePeriodSlider,
                              min: 1,
                              max: 40,
                              onChanged: (value) {
                                setState(() {
                                  timePeriodSlider = value;
                                  timePeriodController.text =
                                      value.toStringAsFixed(0);
                                });
                              },
                              activeColor: const Color(0xff19BC8A),
                              inactiveColor: const Color(0xffEFF1F5),
                            ),
                          ),
                          const SizedBox(
                            height: 42,
                          ),
                          GestureDetector(
                            onTap: () {
                              final (first, second, third) = calculateForSip(
                                  double.parse(howMuchToInvestController.text),
                                  double.parse(expectedReturnController.text),
                                  double.parse(timePeriodController.text));
                              setState(() {
                                expectedReturns = first;
                                totalInvestments = second;
                                totalValue = third;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: const BoxDecoration(
                                  color: Color(0xff3F4599),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: const Center(
                                child: Text(
                                  'Calculate',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                color:
                                    const Color(0xff20BE8D).withOpacity(0.15)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Expected returns',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      const SizedBox(
                                        height: 13,
                                      ),
                                      Text(
                                        '₹ ${expectedReturns.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Total Investment',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹ ${totalInvestments.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Total Value',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                    const Spacer(),
                                    Text(
                                      totalValue.toStringAsFixed(2),
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 24),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                color:
                                    const Color(0xff4E57CD).withOpacity(0.15)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/images/svg/i2.svg'),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    const Text(
                                      'Risk and Return Fundamentals',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xff3F4599),
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  'Risk is the uncertainty in investment returns or the variability of returns linked to an asset.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                const Text(
                                  'Return is the net gain or loss on an investment, calculated by adding cash distributions and value change, then dividing by the initial investment.',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
