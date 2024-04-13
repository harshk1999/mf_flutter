import 'package:flutter/material.dart';

class CustomSliderThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(30, 30); // Adjust the size of the thumb as needed
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    Animation<double>? activationAnimation,
    Animation<double>? enableAnimation,
    bool? isDiscrete,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final canvas = context.canvas;

    // Draw the thumb using the provided SVG as a reference
    final thumbPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: 15));

    // Customize the thumb appearance
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.square
      ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5.0);

    canvas.drawPath(thumbPath, paint);
  }
}
