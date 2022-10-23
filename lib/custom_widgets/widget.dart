import 'package:flutter/material.dart';
import 'package:weather_api/models/weather_info.dart';

class RPSCustomPainter extends CustomPainter {
  WeatherInfo weatherInfo = WeatherInfo();
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.1253250);
    path0.lineTo(0, size.height);
    path0.lineTo(size.width, size.height);
    path0.lineTo(size.width, size.height * 0.1253500);
    path0.quadraticBezierTo(size.width * 0.9953125, size.height * 0.0112000,
        size.width * 0.9375250, 0);
    path0.cubicTo(
        size.width * 0.8136625,
        size.height * 0.0241250,
        size.width * 0.8115250,
        size.height * 0.0720500,
        size.width * 0.4999875,
        size.height * 0.0734500);
    path0.cubicTo(
        size.width * 0.1885375,
        size.height * 0.0741750,
        size.width * 0.1876375,
        size.height * 0.0229250,
        size.width * 0.0627375,
        0);
    path0.quadraticBezierTo(size.width * 0.0053000, size.height * 0.0018750, 0,
        size.height * 0.1253250);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
