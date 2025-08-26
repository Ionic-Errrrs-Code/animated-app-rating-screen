import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../utils/helpers.dart';

class AnimatedFace extends StatelessWidget {
  final double percentage;
  final Color darkColor;
  final Size faceSize;

  const AnimatedFace({
    super.key,
    required this.percentage,
    required this.darkColor,
    required this.faceSize,
  });

  @override
  Widget build(BuildContext context) {
    final double eyeWidth, eyeHeight, eyeRotation, mouthRotation;

    if (percentage <= 0.5) {
      final t = percentage / 0.5;
      eyeWidth = lerpDouble(faceSize.width * 0.2, faceSize.width * 0.4, t);
      eyeHeight = lerpDouble(faceSize.height * 0.4, faceSize.height * 0.15, t);
      eyeRotation = lerpDouble(20.0, 0.0, t);
      mouthRotation = math.pi;
    } else {
      final t = (percentage - 0.5) / 0.5;
      eyeWidth = lerpDouble(faceSize.width * 0.4, faceSize.width * 0.3, t);
      eyeHeight = lerpDouble(faceSize.height * 0.15, faceSize.width * 0.3, t);
      eyeRotation = 0.0;
      mouthRotation = lerpDouble(math.pi, 0.0, t);
    }

    return SizedBox(
      width: faceSize.width,
      height: faceSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedEye(width: eyeWidth, height: eyeHeight, color: darkColor, rotation: -eyeRotation, percentage: percentage),
              SizedBox(width: faceSize.width * 0.1),
              AnimatedEye(width: eyeWidth, height: eyeHeight, color: darkColor, rotation: eyeRotation, percentage: percentage),
            ],
          ),
          SizedBox(height: faceSize.height * 0.1),
          AnimatedMouth(
            rotation: mouthRotation,
            color: darkColor,
            // --- Mouth size adjusted ---
            size: Size(faceSize.width * 0.25, faceSize.height * 0.18),
          ),
        ],
      ),
    );
  }
}

// ... (AnimatedEye class remains the same)
class AnimatedEye extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double rotation;
  final double percentage;

  const AnimatedEye({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.rotation,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius borderRadius;
    if (percentage <= 0.5) {
      borderRadius = BorderRadius.circular(width / 2);
    } else if (percentage < 1.0) {
      borderRadius = BorderRadius.circular(height / 2);
    } else {
      borderRadius = BorderRadius.circular(width / 2);
    }
    return Transform.rotate(
      angle: rotation * (math.pi / 180),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 0),
        width: width,
        height: height,
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
      ),
    );
  }
}


class AnimatedMouth extends StatelessWidget {
  final double rotation;
  final Color color;
  final Size size;

  const AnimatedMouth({super.key, required this.rotation, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: CustomPaint(size: size, painter: MouthPainter(color: color)),
    );
  }
}

class MouthPainter extends CustomPainter {
  final Color color;
  MouthPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      // --- Mouth radius/thickness adjusted ---
      ..strokeWidth = size.width * 0.3
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(size.width * 0.5, size.height, size.width, size.height * 0.5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
