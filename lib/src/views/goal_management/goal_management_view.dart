import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_app/src/views/goal_management/helper/goal_management_conatiner.dart';

class GoalManagementView extends StatefulWidget {
  const GoalManagementView({super.key});

  @override
  State<GoalManagementView> createState() => _GoalManagementViewState();
}

class _GoalManagementViewState extends State<GoalManagementView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        toolbarHeight: 44,
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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/images/svg/goalManagement.svg',
                height: 70,
                width: 80,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "A goal without a plan is just a wish",
              style: TextStyle(
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
            const Text(
              "Knowing what you want in life is vital, and figuring out the exact amount you need to achieve those goals is just as important.",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff5f646f),
                  height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 24,
            ),

            const Row(
              children: [
                Expanded(
                  child: GoalManagementContainer(
                    goalName: 'Child Education',
                    img: 'assets/images/svg/child_education.svg',
                    about:
                        'Empower Their Future: Investing in Knowledge, Nurturing Dreams.',
                  ),
                ),
                SizedBox(
                  width: 18,
                ),
                Expanded(
                  child: GoalManagementContainer(
                    goalName: 'Buy a Car',
                    img: 'assets/images/svg/car.svg',
                    about:
                        'Accelerate Ambitions: Turning the Key to Your Dream Car Aspirations.',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),

            const Row(
              children: [
                GoalManagementContainer(
                  goalName: 'Desired Vacation',
                  img: 'assets/images/svg/vacation.svg',
                  about:
                      'Calculate the amount you need to make your next vacation enjoyable.',
                ),
                SizedBox(
                  width: 18,
                ),
                GoalManagementContainer(
                  goalName: 'Child Marriage',
                  img: 'assets/images/svg/ring.svg',
                  about:
                      'Calculate the amount you need to make your Child Marriage Memorable.',
                ),
              ],
            ),

            const SizedBox(
              height: 18,
            ),

            const Row(
              children: [
                GoalManagementContainer(
                  goalName: 'Dream House',
                  img: 'assets/images/svg/house.svg',
                  about:
                      'Achieving your dream home is a goal that takes time. Planning for it demands patience and discipline.',
                ),
                SizedBox(
                  width: 18,
                ),
                GoalManagementContainer(
                  goalName: 'Other Goals ',
                  img: 'assets/images/svg/other_goals.svg',
                  about:
                      'Enter your financial goal and use our calculator to find the best plan to help you achieve it.',
                ),
              ],
            ),

            // const Row(
            //   children: [
            //     GoalManagementContainer(
            //         goalName: 'Child Education',
            //         img: 'assets/images/svg/child_education.svg'),
            //     SizedBox(
            //       width: 18,
            //     ),
            //     GoalManagementContainer(
            //         goalName: 'Buy a Car', img: 'assets/images/svg/car.svg'),
            //   ],
            // ),
            // const SizedBox(
            //   height: 18,
            // ),
            // const Row(
            //   children: [
            //     GoalManagementContainer(
            //         goalName: 'Desired Vacation',
            //         img: 'assets/images/svg/vacation.svg'),
            //     SizedBox(
            //       width: 18,
            //     ),
            //     GoalManagementContainer(
            //         goalName: 'Child Marriage',
            //         img: 'assets/images/svg/ring.svg'),
            //   ],
            // ),
            // const SizedBox(
            //   height: 18,
            // ),
            // const Row(
            //   children: [
            //     GoalManagementContainer(
            //         goalName: 'Dream House',
            //         img: 'assets/images/svg/house.svg'),
            //     SizedBox(
            //       width: 18,
            //     ),
            //     GoalManagementContainer(
            //         goalName: 'Other Goals ',
            //         img: 'assets/images/svg/other_goals.svg'),
            //   ],
            // ),

            // const GoalManagementContainer(
            //     goalName: 'Dream Car',
            //     about:
            //         'Accelerate Ambitions: Turning the\n Key to Your Dream Car Aspirations.',
            //     // calculateNow: () {},
            //     img: 'assets/images/svg/child_education.svg'),
            // const SizedBox(
            //   height: 16,
            // ),
            // const GoalManagementContainer(
            //     goalName: 'Dream Vacation',
            //     about:
            //         'Calculate the amount you need to\n make your next vacation enjoyable.\n Start planning for it today.',
            //     // calculateNow: () {},
            //     img: 'assets/images/svg/child_education.svg'),
            // const SizedBox(
            //   height: 16,
            // ),
            // const GoalManagementContainer(
            //     goalName: 'Child Marriage',
            //     about:
            //         'Calculate the amount you need to\n make your Child Marriage Memorable.\n Start planning for it today.',
            //     // calculateNow: () {},
            //     img: 'assets/images/svg/child_education.svg'),
            // const SizedBox(
            //   height: 16,
            // ),
            // const GoalManagementContainer(
            //     goalName: 'Dream House',
            //     about:
            //         'Calculate the amount you need to\n Build your dream house.\n Start planning for it today',
            //     // calculateNow: () {},
            //     img: 'assets/images/svg/child_education.svg'),
            // const SizedBox(
            //   height: 16,
            // ),
            // const GoalManagementContainer(
            //     goalName: 'Other Goals',
            //     about: 'Plan any other goals also',
            //     // calculateNow: () {},
            //     img: 'assets/images/svg/child_education.svg'),
            // const SizedBox(
            //   height: 16,
            // ),
          ],
        ),
      ),
    );
  }
}
