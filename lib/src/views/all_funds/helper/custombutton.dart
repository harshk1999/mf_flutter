import 'package:flutter/material.dart';

class CustomButtonContainer extends StatelessWidget {
  final Text buttonName;
  final Color color;
  const CustomButtonContainer(
      {super.key, required this.buttonName, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
      height: 54,
      width: 185,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 8),
                blurRadius: 15,
                color: const Color(0xff3F4599).withOpacity(0.36))
          ],
          color: color,
          border: Border.all(
            width: 1,
            color: const Color(0xff3F4599),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: buttonName,
    );
  }
}
