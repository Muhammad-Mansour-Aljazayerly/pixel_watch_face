import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ConcentricClock extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    _drawSecondsCircle(canvas, size, 135.0);
    _drawMinutesCircle(canvas, size, 95.0);
    _drawHourText(canvas, size);
    _drawRightIndicator(canvas, size);
  }

  _drawRightIndicator(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    var center = Offset(size.height * 0.5, size.height * 0.5);
    var radius = 135.0;

    var startPoint = Offset(center.dx + radius, center.dy + 20);
    var endPoint = Offset(center.dx + radius, center.dy - 20);
    var controlPoint1 = Offset(center.dx + 30, center.dy + 15);
    var controlPoint2 = Offset(center.dx + 30, center.dy - 15);

    var path = Path()
      ..moveTo(startPoint.dx, startPoint.dy)
      ..lineTo(center.dx + 50, startPoint.dy)
      ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, center.dx + 50, startPoint.dy - 40)
      ..lineTo(endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  _drawHourText(Canvas canvas, Size size) {
    var center = Offset(size.height * 0.5, size.height * 0.5);
    var textPainter = TextPainter()..textDirection = TextDirection.ltr;

    textPainter.text = TextSpan(
      text: intl.DateFormat('hh').format(DateTime.now()),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    var textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, textOffset);
  }

  _drawSecondsCircle(Canvas canvas, Size size, double radius) {
    var center = Offset(size.height * 0.5, size.height * 0.5);

    // draw minutes ticks
    for (var i = 0; i < 360; i += 6) {
      var second = DateTime.now().second;
      var millisecond = DateTime.now().millisecond;

      var secondAngle = (((((second) * 6) + (millisecond / 170)))) * pi / 180;

      var angle = (i * (pi / 180)) + secondAngle;
      var startX = center.dx + radius * cos(angle);
      var startY = center.dy + radius * sin(angle);
      var startPoint = Offset(startX, startY);

      double tickLength = 4.0;
      // To make hour tick thicker
      if (i % 30 == 0) tickLength = 7;

      var endX = center.dx + (radius - tickLength) * cos(angle);
      var endY = center.dy + (radius - tickLength) * sin(angle);
      var endPoint = Offset(endX, endY);

      var tickPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 1.2;

      canvas.drawLine(startPoint, endPoint, tickPaint);
    }

    // draw hours text
    for (var i = 0; i < 360; i += 30) {
      var second = DateTime.now().second;
      var millisecond = DateTime.now().millisecond;

      var secondAngle = (((((second) * 6) + (millisecond / 170)))) * pi / 180;

      var hourAngle = -i * pi / 180;

      var textPainter = TextPainter()..textDirection = TextDirection.ltr;

      textPainter.text = TextSpan(
        text: (i / 6).toStringAsFixed(0),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      );
      textPainter.layout();
      var textOffset = Offset(
        center.dx +
            (radius - 22) * cos(hourAngle + secondAngle) -
            textPainter.width / 2,
        center.dy +
            (radius - 22) * sin(hourAngle + secondAngle) -
            textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }
  }

  _drawMinutesCircle(Canvas canvas, Size size, double radius) {
    var center = Offset(size.height * 0.5, size.height * 0.5);

    // draw minutes ticks
    for (var i = 0; i < 360; i += 6) {
      var minute = DateTime.now().minute;

      var minuteAngle = ((minute * 6)) * pi / 180;

      var angle = (i * (pi / 180)) + minuteAngle;
      var startX = center.dx + radius * cos(angle);
      var startY = center.dy + radius * sin(angle);
      var startPoint = Offset(startX, startY);

      double tickLength = 4.0;
      // To make hour tick thicker
      if (i % 30 == 0) tickLength = 7;

      var endX = center.dx + (radius - tickLength) * cos(angle);
      var endY = center.dy + (radius - tickLength) * sin(angle);
      var endPoint = Offset(endX, endY);

      var tickPaint = Paint()
        ..color = Colors.white70
        ..strokeWidth = 1.2;

      canvas.drawLine(startPoint, endPoint, tickPaint);
    }

    // draw hours text
    for (var i = 0; i < 360; i += 6) {
      var minute = DateTime.now().minute;
      var minuteAngle = ((minute * 6)) * pi / 180;
      var textPainter = TextPainter()..textDirection = TextDirection.ltr;
      var hourAngle = -i * pi / 180;

      if ((i / 6) == minute) {
        textPainter.text = TextSpan(
          text: (i / 6).toStringAsFixed(0),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        );
        textPainter.layout();
        var textOffset = Offset(
          center.dx +
              (radius - 30) * cos(hourAngle + minuteAngle) -
              textPainter.width / 2,
          center.dy +
              (radius - 30) * sin(hourAngle + minuteAngle) -
              textPainter.height / 2,
        );
        textPainter.paint(canvas, textOffset);
      } else if ((i % 30 == 0) && (hourAngle + minuteAngle > 0.25) ||
          (i % 30 == 0) && (hourAngle + minuteAngle < -0.25)) {
        textPainter.text = TextSpan(
          text: (i / 6).toStringAsFixed(0),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        );
        textPainter.layout();
        var textOffset = Offset(
          center.dx +
              (radius - 22) * cos(hourAngle + minuteAngle) -
              textPainter.width / 2,
          center.dy +
              (radius - 22) * sin(hourAngle + minuteAngle) -
              textPainter.height / 2,
        );
        textPainter.paint(canvas, textOffset);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
