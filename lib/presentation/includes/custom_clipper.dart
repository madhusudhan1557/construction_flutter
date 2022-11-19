import 'package:flutter/material.dart';

class CustomCurve extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    Offset firststart = Offset(size.width / 6.23, size.height / 1.82);
    Offset firstend = Offset(size.width / 2.31, size.height / 1.263);
    path.quadraticBezierTo(
        firststart.dx, firststart.dy, firstend.dx, firstend.dy);
    Offset secondstart = Offset(size.width / 1.1, size.height / 0.83);
    Offset secondend = Offset(size.width, size.height / 1.67);
    path.quadraticBezierTo(
        secondstart.dx, secondstart.dy, secondend.dx, secondend.dy);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
