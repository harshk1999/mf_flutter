import 'package:flutter/material.dart';

class CustomContainerForAllFundsContainer extends StatelessWidget {
  const CustomContainerForAllFundsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 52,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
        gradient: LinearGradient(
          stops: [.5, .5],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffE7E8EE),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
