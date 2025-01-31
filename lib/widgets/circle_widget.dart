import 'dart:math';

import 'package:flutter/material.dart';

class CircleChart extends CustomPainter {
  num value;
  bool turbidity;

  CircleChart(this.value, this.turbidity);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int maximumValue = turbidity ? 100 : 125;

    Paint outerCircle = Paint()
      ..strokeWidth = 10
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    Paint turb = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = (value == maximumValue || value > maximumValue)
          ? Colors.green
          : Colors.blue;

    Paint temp = Paint()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = (value == maximumValue) ? Colors.green : Colors.red;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 10;
    canvas.drawCircle(center, radius, outerCircle);

    double angle = 2 * pi * (value / maximumValue);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, turbidity ? turb : temp);
  }
}
