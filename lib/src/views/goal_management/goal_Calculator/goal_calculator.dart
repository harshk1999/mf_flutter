import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_app/src/app/routes/routes.dart';
import 'package:mf_app/src/views/goal_management/goal_Calculator/goal_calculator_view_model.dart';

class GoalCalculatorScreenArguments {
  final String goalName;
  final String img;
  final double monthlyInvestmentRequired;
  final double inflationAdjustedValue;
  final double projectedSavings;
  final int years;

  GoalCalculatorScreenArguments({
    required this.goalName,
    required this.img,
    required this.monthlyInvestmentRequired,
    required this.inflationAdjustedValue,
    required this.projectedSavings,
    required this.years,
  });

  // const GoalCalculatorScreenArguments(this.img, this.inflationAdjustedValue,
  //     {required this.goalName, required this.monthlyInvestmentRequired});
}

class GoalCalculator extends StatefulWidget {
  final String goalName;
  final String about;
  final String img;
  const GoalCalculator({
    super.key,
    required this.goalName,
    required this.img,
    required this.about,
  });

  @override
  State<GoalCalculator> createState() => _GoalCalculatorState();
}

class _GoalCalculatorState extends State<GoalCalculator> {
  late final TextEditingController timePeriodController;
  late final TextEditingController estimatedCostController;
  late final TextEditingController investmentController;
  late final TextEditingController annualReturnController;

  // bool validate = false;

  double sliderValue = 0;
  double sliderValue1 = 0;
  double sliderValue2 = 0;
  double sliderValue3 = 0;
  late final GoalCalculatorViewModel gcvm;
  @override
  void initState() {
    super.initState();
    timePeriodController = TextEditingController();
    estimatedCostController = TextEditingController();
    investmentController = TextEditingController();
    annualReturnController = TextEditingController();
    gcvm = GoalCalculatorViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 8,
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  widget.img,
                  width: 45,
                  height: 32,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.goalName,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff161719),
                    height: 24 / 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(widget.about,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xff5F6570))),
                const SizedBox(
                  height: 8,
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
                "In how many years you need\nthis money?",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff161719),
                ),
                textAlign: TextAlign.left,
              ),
              const Spacer(),
              Container(
                width: 96,
                height: 36,
                // padding: const EdgeInsets.only(top: 6, left: 8, right: 8),
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    border:
                        Border.all(width: 1, color: const Color(0xffDDE0E7)),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: TextField(
                  textAlign: TextAlign.left,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  style: const TextStyle(
                      height: 1, fontSize: 12, color: Colors.black),
                  controller: timePeriodController,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  // showCursor: false,

                  cursorWidth: 2,
                  cursorHeight: 12,
                  decoration: const InputDecoration(
                    // errorText: validate ? 'Value Cannot be Empty' : null,
                    suffixText: "Years",
                    suffixStyle: TextStyle(
                        color: Color(0xff7E838D),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontFamily: 'Poppins'),
                    isDense: true,
                    contentPadding: EdgeInsets.all(8),
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SliderTheme(
            data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
            child: Slider(
              value: sliderValue.roundToDouble(),
              onChanged: (newValue) {
                setState(() {
                  sliderValue = newValue.roundToDouble();
                  timePeriodController.text = newValue.toStringAsFixed(0);
                });
              },
              // min: 0,
              max: 40,
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
                "Estimated cost as per today?",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff161719),
                ),
                textAlign: TextAlign.left,
              ),
              const Spacer(),
              // const SizedBox(
              //   height: 24,
              // ),
              Container(
                width: 96,
                height: 32,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    border:
                        Border.all(width: 1, color: const Color(0xffDDE0E7)),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                  style: const TextStyle(
                      height: 1, fontSize: 12, color: Colors.black),
                  controller: estimatedCostController,
                  // keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  // showCursor: false,
                  cursorWidth: 2,
                  cursorHeight: 12,
                  decoration: const InputDecoration(
                    // errorText: validate ? 'Value cannot be empty' : null,
                    isDense: true,
                    border: InputBorder.none,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SliderTheme(
            data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
            child: Slider(
              value: sliderValue1,
              onChanged: (value) {
                setState(() {
                  sliderValue1 = value;
                  estimatedCostController.text = value.toStringAsFixed(0);
                });
              },
              max: 10000000,
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
                "How much you can invest per\nmonth?",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff161719),
                ),
                textAlign: TextAlign.left,
              ),
              const Spacer(),
              Container(
                width: 96,
                height: 32,
                padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    border:
                        Border.all(width: 1, color: const Color(0xffDDE0E7)),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                child: SizedBox(
                  height: 16,
                  width: 18,
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.singleLineFormatter
                    ],
                    style: const TextStyle(
                        height: 1, fontSize: 14, color: Colors.black),
                    controller: investmentController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    // showCursor: false,
                    cursorWidth: 2,
                    cursorHeight: 12,
                    decoration: const InputDecoration(
                      prefix: Text('₹'),
                      prefixStyle: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff161719),
                      ),
                      isDense: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SliderTheme(
            data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
            child: Slider(
              // label: sliderValue2.toString(),
              value: sliderValue2,
              onChanged: (value) {
                setState(() {
                  sliderValue2 = value;
                  investmentController.text = value.toStringAsFixed(0);
                });
              },
              // min: 0,
              max: 10000000,
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
                "Expected Annual Return?",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff161719),
                ),
                textAlign: TextAlign.left,
              ),
              const Spacer(),
              ValueListenableBuilder(
                  valueListenable: gcvm.toggleNotifier,
                  builder: (_, toggle, __) {
                    return Container(
                      height: 32,
                      width: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              width: 1, color: const Color(0xffDDE0E7)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4))),
                      child: DropdownButton(
                          underline: const SizedBox(),
                          value: toggle,
                          isExpanded: true,
                          items:
                              gcvm.getAnnualReturnNames().map((String value) {
                            return DropdownMenuItem(
                                // alignment: Alignment.center,
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Text(
                                    value,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff161719),
                                    ),
                                  ),
                                ));
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              gcvm.toggleFilterNames(newValue);
                            }
                          }),
                    );
                  })
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Container(
            padding: const EdgeInsets.only(left: 14, top: 10, bottom: 10),
            height: 40,
            width: double.infinity,
            color: const Color(0xffF8F8F8),
            child: const Text(
              'This could potentially yield a 12% return.',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          GestureDetector(
            onTap: () {
              if (timePeriodController.text.isNotEmpty &&
                  estimatedCostController.text.isNotEmpty &&
                  investmentController.text.isNotEmpty) {
                Navigator.of(context).pushNamed(AppRoutes.goalPlan,
                    arguments: GoalCalculatorScreenArguments(
                      goalName: widget.goalName,
                      monthlyInvestmentRequired: gcvm.pv(
                          double.parse(estimatedCostController.text),
                          double.parse(timePeriodController.text),
                          12,
                          6),
                      inflationAdjustedValue:
                          gcvm.calculateInflationAdjustedValue(
                              double.parse(estimatedCostController.text),
                              double.parse(timePeriodController.text),
                              6),
                      img: widget.img,
                      projectedSavings: double.parse(investmentController.text),
                      years: int.parse(timePeriodController.text),
                    ));
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                // color: Color((timePeriodController.text.isNotEmpty &&
                //         estimatedCostController.text.isNotEmpty &&
                //         investmentController.text.isNotEmpty)
                //     ? 0xff3F4599
                //     : 0xff00001f)),
                color: Color(0xff3F4599),
              ),
              child: const Center(
                child: Text(
                  'Calculate My Goal Plan',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
