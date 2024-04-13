import 'package:flutter/material.dart';

class TypeContainer extends StatelessWidget {
  final String text;
  const TypeContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
      decoration: const BoxDecoration(
          color: Color(0xffEFF1F5),
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 10,
          color: Color(0xff5F6570),
        ),
      ),
    );
  }
}
