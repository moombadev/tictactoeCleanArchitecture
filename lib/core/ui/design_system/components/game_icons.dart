import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GameIconX extends StatelessWidget {
  const GameIconX({
    super.key,
    required this.size,
    this.color = AppColors.primary,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _XPainter(color: color),
    );
  }
}

class _XPainter extends CustomPainter {
  _XPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final padding = size.width * 0.2;
    final cornerRadius = size.width * 0.02;
    final center = Offset(size.width / 2, size.height / 2);
    
    final path1 = Path()
      ..moveTo(padding, padding)
      ..lineTo(center.dx - cornerRadius, center.dy - cornerRadius)
      ..quadraticBezierTo(
        center.dx,
        center.dy,
        center.dx + cornerRadius,
        center.dy + cornerRadius,
      )
      ..lineTo(size.width - padding, size.height - padding);
    
    final path2 = Path()
      ..moveTo(size.width - padding, padding)
      ..lineTo(center.dx + cornerRadius, center.dy - cornerRadius)
      ..quadraticBezierTo(
        center.dx,
        center.dy,
        center.dx - cornerRadius,
        center.dy + cornerRadius,
      )
      ..lineTo(padding, size.height - padding);
    
    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GameIconO extends StatelessWidget {
  const GameIconO({
    super.key,
    required this.size,
    this.color = AppColors.primary,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: size * 0.3,
        ),
      ),
    );
  }
}

