import 'dart:ui';

import 'package:flutter/material.dart';

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final pointA = Offset(size.width * 0.15, 0);
    final pointB = Offset(size.width, 0);
    final pointC = Offset(size.width, size.height);

    path.moveTo(pointA.dx, pointA.dy);
    path.lineTo(pointB.dx, pointB.dy);
    path.lineTo(pointC.dx, pointC.dy);

    final waveLength = (pointC.dx - pointA.dx) / 2;

    final controlPoint1X = pointC.dx - waveLength * 1.75;
    final controlPoint1Y = size.height * 1.5;
    final controlPoint2X = pointC.dx - waveLength * 0.95;
    final controlPoint2Y = size.height * 0.2;

    path.cubicTo(
      controlPoint2X,
      controlPoint2Y,
      controlPoint1X,
      controlPoint1Y,
      pointA.dx,
      pointA.dy,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
