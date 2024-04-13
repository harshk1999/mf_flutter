import 'package:flutter/material.dart';

class FixSlider extends StatelessWidget {
  const FixSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2)),
          gradient: LinearGradient(colors: [
            Color(0xffFFFFFF),
            Color(0xff27AA6B),
          ])),
    );
  }
}
