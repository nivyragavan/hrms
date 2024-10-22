import 'dart:math';

import 'package:flutter/material.dart';

class CircularProgressBar extends StatelessWidget {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  CircularProgressBar({
    required this.progress,
    this.strokeWidth = 5.0,
    this.progressColor = Colors.blue,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(100.0),
      painter: CircularProgressBarPainter(
        progress: progress,
        strokeWidth: strokeWidth,
        progressColor: progressColor,
        backgroundColor: backgroundColor,
      ),
    );
  }
}

class CircularProgressBarPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  CircularProgressBarPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      2 * pi,
      false,
      backgroundPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressBarPainter oldDelegate) {
    return progress != oldDelegate.progress ||
        strokeWidth != oldDelegate.strokeWidth ||
        progressColor != oldDelegate.progressColor ||
        backgroundColor != oldDelegate.backgroundColor;
  }
}
