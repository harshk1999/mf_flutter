import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_app/src/app/routes/routes.dart';

class GoalManagementScreenArguments {
  final String goalName;
  final String about;
  final String img;

  const GoalManagementScreenArguments(this.img, this.about,
      {required this.goalName});
}

class GoalManagementContainer extends StatelessWidget {
  final String goalName;
  final String about;
  final String img;

  const GoalManagementContainer(
      {super.key,
      required this.goalName,
      required this.img,
      required this.about});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 128,
      // width: 180,
      padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 20),
      decoration: BoxDecoration(
          color: const Color(0xffF9FDFC),
          border: Border.all(width: 1, color: const Color(0xffEFF1F5)),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const SizedBox(
          //   height: 20,
          // ),
          SvgPicture.asset(
            img,
            height: 22.81,
            width: 32,
          ),
          const SizedBox(
            height: 12,
          ),
          Wrap(children: [
            Text(
              goalName,
              maxLines: 1,
              style: const TextStyle(
                fontFamily: "Poppins",
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xff161719),
              ),
              textAlign: TextAlign.center,
            ),
          ]),
          const SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.goalCalculator,
                  arguments: GoalManagementScreenArguments(img, about,
                      goalName: goalName));
            },
            child: const Text(
              "Calculate Now",
              maxLines: 1,
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontFamily: "Poppins",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xff3f4599),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
