import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

class DonutChart extends StatelessWidget {
  const DonutChart(
      {super.key,
      required this.open,
      required this.overdue,
      required this.closed,
      required this.total});
  final int open;
  final int overdue;
  final int closed;
  final int total;
  @override
  Widget build(BuildContext context) => SizedBox(
      width: 126,
      height: 126,
      child: CustomPaint(
          painter: _DonutPainter(
              open: open, overdue: overdue, closed: closed, total: total),
          child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text('$total',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            const Text('Tasks',
                style: TextStyle(fontSize: 9, color: AppColors.secondaryText))
          ]))));
}

class _DonutPainter extends CustomPainter {
  _DonutPainter(
      {required this.open,
      required this.overdue,
      required this.closed,
      required this.total});
  final int open;
  final int overdue;
  final int closed;
  final int total;
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 8;
    final stroke = radius * .15;
    final values = [open, overdue, closed];
    final colors = [AppColors.yellow, AppColors.red, AppColors.green];
    var start = -math.pi / 2;
    const gap = .045;
    for (var i = 0; i < values.length; i++) {
      if (total == 0 || values[i] == 0) continue;
      final sweep = (values[i] / total) * math.pi * 2 - gap;
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), start,
          sweep, false, paint);
      start += sweep + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.open != open ||
      oldDelegate.overdue != overdue ||
      oldDelegate.closed != closed ||
      oldDelegate.total != total;
}
