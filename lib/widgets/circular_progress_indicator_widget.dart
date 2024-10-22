import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../controller/theme_controller.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  CircularProgressIndicatorWidget({
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100), // Adjust the size as needed
      painter: ProgressPainter(
        totalSteps: totalSteps,
        currentStep: currentStep,
      ),
    );
  }
}
class ProgressPainter extends CustomPainter {
  final int totalSteps;
  final int currentStep;

  ProgressPainter({
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.grey; // Default color for uncompleted steps

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    if (totalSteps == 1) {
      // Special case when totalSteps is 1
      if (currentStep == 0) {
        paint.color = AppColors.lightGrey; // Grey color for currentStep 0
        canvas.drawCircle(center, radius, paint);
      } else if (currentStep == 1) {
        paint.color = AppColors.blue; // Blue color for currentStep 1
        canvas.drawCircle(center, radius, paint);
      }
      // Draw an empty space in the center
      final emptyCenterRadius = radius * 0.8;
      canvas.drawCircle(center, emptyCenterRadius, Paint()..color = Colors.transparent);

      // Draw the inner circle with your desired color
      paint.color = ThemeController.to.checkThemeCondition() == true ? Colors.grey.shade900 : AppColors.white;
      canvas.drawCircle(center, emptyCenterRadius, paint);
    } else {
      double gapAngle = 2 * 3.141592653589793238 / totalSteps * 0.1; // Adjust the gap size here
      final double stepAngle = (2 * 3.141592653589793238 - (gapAngle * (totalSteps - 1))) / totalSteps; // Angle between steps with gaps

      for (int step = 0; step < totalSteps; step++) {
        if (step < currentStep) {
          paint.color = AppColors.blue; // Color for completed steps
        } else {
          paint.color = AppColors.lightGrey; // Color for uncompleted steps
        }

        final double startAngle = step * (stepAngle + gapAngle) - 1.57079632679489661923; // -90 degrees in radians
        final double endAngle = startAngle + stepAngle;

        final path = Path()
          ..moveTo(center.dx, center.dy)
          ..arcTo(Rect.fromCircle(center: center, radius: radius), startAngle, stepAngle - gapAngle, false) // Adjusted for gap
          ..close();

        canvas.drawPath(path, paint);
      }

      // Draw an empty space in the center
      final emptyCenterRadius = radius * 0.8;
      canvas.drawCircle(center, emptyCenterRadius, Paint()..color = Colors.transparent);

      // Draw the inner circle with your desired color
      paint.color = ThemeController.to.checkThemeCondition() == true ? Colors.grey.shade900 : AppColors.white;
      canvas.drawCircle(center, emptyCenterRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}









