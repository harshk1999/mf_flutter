import 'package:flutter/material.dart';

class DetailTypeContainer extends StatelessWidget {
  final String text;
  const DetailTypeContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: const Color(0xffDDE0E7)),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Text(
        text,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: 'Poppins',
            color: Color(0xff3F424C),
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
