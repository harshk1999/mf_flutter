import 'package:flutter/material.dart';

class CustomPainterForRatingContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFF3F4599)
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(16.6558, 17.3183);
    path.cubicTo(18.9182, 19.6706, 22.0411, 21, 25.3049, 21);
    path.lineTo(56, 21);
    path.lineTo(56, 7);
    path.cubicTo(56, 3.13401, 52.866, 0, 49, 0);
    path.lineTo(0, 0);
    path.lineTo(16.6558, 17.3183);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
