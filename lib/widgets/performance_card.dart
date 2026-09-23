import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reside/widgets/avatar.dart';

import '../models/team_member.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({
    super.key,
    required this.member,
    required this.open,
    required this.overdue,
    required this.closed,
  });

  final TeamMember member;
  final int open;
  final int overdue;
  final int closed;

  @override
  Widget build(BuildContext context) {
    final int total = open + overdue + closed;

    return Container(
      width: double.infinity,
      height: 253.16,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFD9DEE5),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Avatar(
                member: member,
                size: 20,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF222222),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const double maxGraphSize = 185.16;
                const double figmaGap = 32.0;
                const double minLegendWidth = 90.0;

                final double availableWidth = constraints.maxWidth;

                // Figma:
                // Graph = 185.16
                // Gap = 32
                // Legend ≈ 107.22
                //
                // Small screen par graph automatically shrink hoga.
                final double graphSize = math.min(
                  maxGraphSize,
                  math.max(
                    120.0,
                    availableWidth - figmaGap - minLegendWidth,
                  ),
                );

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: graphSize,
                      height: graphSize,
                      child: CustomPaint(
                        painter: _PerformanceChartPainter(
                          open: open,
                          overdue: overdue,
                          closed: closed,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$total',
                                style: const TextStyle(
                                  // fontSize: graphSize >= 175 ? 32 : 28,
                                  fontSize: 44,
                                  height: 1,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF000000),
                                ),
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                'Tasks',
                                style: TextStyle(
                                  // fontSize: graphSize >= 175 ? 12 : 9,
                                  fontSize: 12,
                                  color: Color(0xFF9291A5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: availableWidth >=
                              (maxGraphSize + figmaGap + minLegendWidth)
                          ? figmaGap
                          : 16.0,
                    ),

                    // ========================================================
                    // LEGEND
                    // ========================================================

                    Expanded(
                      child: _Legend(
                        open: open,
                        overdue: overdue,
                        closed: closed,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({
    required this.open,
    required this.overdue,
    required this.closed,
  });

  final int open;
  final int overdue;
  final int closed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 185.16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LegendItem(
            color: const Color(0xFFFFD34E),
            label: 'Open',
            value: open,
          ),

          _LegendItem(
            color: const Color(0xFFFF0000),
            label: 'Overdue',
            value: overdue,
          ),

          _LegendItem(
            color: const Color(0xFF477E2D),
            label: 'Closed',
            value: closed,
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Dot
          Container(
            width: 13,
            height: 13,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 5),

          // Label
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 1.5,
              letterSpacing: 0,
              color: const Color(0xFF9291A5),
            ),
          ),

          const SizedBox(width: 3),

          // Value
          Text(
            '$value',
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 0,
              color: const Color(0xFF1E1B39),
            ),
          ),
        ],
      ),
    );
  }
}

class _PerformanceChartPainter extends CustomPainter {
  const _PerformanceChartPainter({
    required this.open,
    required this.overdue,
    required this.closed,
  });

  final int open;
  final int overdue;
  final int closed;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final double radius =
        (math.min(size.width, size.height) / 2 - 8)
            .toDouble();

    
    const double strokeWidth = 10.0;

    final int total = open + overdue + closed;

    if (total == 0) {
      final Paint paint = Paint()
        ..color = const Color(0xFFE8E8E8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      canvas.drawCircle(
        center,
        radius,
        paint,
      );

      return;
    }

    final List<int> values = [
      open,
      overdue,
      closed,
    ];

    final List<Color> colors = [
      const Color(0xFFFFD34E), // Open
      const Color(0xFFFF0000), // Overdue
      const Color(0xFF477E2D), // Closed
    ];
    double startAngle = -math.pi / 2;
    const double gap = 0.16;
    for (int i = 0; i < values.length; i++) {
      final int value = values[i];

      if (value <= 0) {
        continue;
      }

      final double sweepAngle =
          (value / total) * (math.pi * 2);

      final double actualSweep = math.max(
        0.0,
        sweepAngle - gap,
      ).toDouble();

      final Paint paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
        startAngle + (gap / 2),

        actualSweep,

        false,

        paint,
      );

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(
    covariant _PerformanceChartPainter oldDelegate,
  ) {
    return oldDelegate.open != open ||
        oldDelegate.overdue != overdue ||
        oldDelegate.closed != closed;
  }
}