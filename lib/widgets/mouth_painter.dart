import 'package:flutter/material.dart';
import 'dart:math' as math;

class MouthPainter extends CustomPainter {
  final double rotation;
  final Color color;

  MouthPainter({
    required this.rotation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    // Save the current canvas state
    canvas.save();
    
    // Move to center and apply rotation
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotation * math.pi / 180);

    // Create the mouth path
    final path = Path();
    path.moveTo(-50, 0);
    path.quadraticBezierTo(0, 50, 50, 0);

    // Draw the mouth
    canvas.drawPath(path, paint);
    
    // Restore the canvas state
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant MouthPainter oldDelegate) {
    return oldDelegate.rotation != rotation || oldDelegate.color != color;
  }
}