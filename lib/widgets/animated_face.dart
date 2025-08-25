import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sparkjoy/models/experience.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Calculate eye properties - oval for bad, flat for not bad, circle for good
    final eyeWidth = _lerpDouble(
      percentage <= 0.5 ? 80.0 : 140.0,  // Bad: oval width, NotBad: flat wide
      percentage <= 0.5 ? 140.0 : 120.0, // NotBad: very wide, Good: circular
      percentage <= 0.5 ? percentage / 0.5 : (percentage - 0.5) / 0.5,
    );
    
    final eyeHeight = _lerpDouble(
      percentage <= 0.5 ? 120.0 : 40.0,  // Bad: oval height, NotBad: flat height
      percentage <= 0.5 ? 40.0 : 120.0,  // NotBad: very flat, Good: circular
      percentage <= 0.5 ? percentage / 0.5 : (percentage - 0.5) / 0.5,
    );
    
    final eyeRotation = _lerpDouble(
      percentage <= 0.5 ? 100.0 : 0.0,
      percentage <= 0.5 ? 0.0 : 0.0,
      percentage <= 0.5 ? percentage / 0.5 : (percentage - 0.5) / 0.5,
    );
    
    // Calculate mouth rotation
    final mouthRotation = percentage <= 0.5
        ? math.pi // 180 degrees for frown
        : _lerpDouble(math.pi, 0.0, (percentage - 0.5) / 0.5);

    return SizedBox(
      width: faceSize.width,
      height: faceSize.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedEye(
                width: eyeWidth * screenWidth * 0.0006,  // Made eyes larger
                height: eyeHeight * screenWidth * 0.0006,
                color: darkColor,
                rotation: -eyeRotation * math.pi / 180,
                experience: _getCurrentExperience(percentage),
              ),
              SizedBox(width: screenWidth * 0.08),  // Slightly more space between eyes
              AnimatedEye(
                width: eyeWidth * screenWidth * 0.0006,  // Made eyes larger
                height: eyeHeight * screenWidth * 0.0006,
                color: darkColor,
                rotation: eyeRotation * math.pi / 180,
                experience: _getCurrentExperience(percentage),
              ),
            ],
          ),
          SizedBox(height: screenWidth * 0.04),  // Reduced spacing between eyes and mouth
          AnimatedMouth(
            rotation: mouthRotation,
            color: darkColor,
            size: screenWidth * 0.08,  // Made mouth even smaller
          ),
        ],
      ),
    );
  }

  double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t.clamp(0.0, 1.0);
  }

  Experience _getCurrentExperience(double percentage) {
    if (percentage <= 0.45) return Experience.bad;
    if (percentage <= 0.55) return Experience.notBad;
    return Experience.good;
  }
}

class AnimatedEye extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double rotation;
  final Experience experience;

  const AnimatedEye({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.rotation,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    // Handle different eye shapes based on experience
    BorderRadius? borderRadius;
    BoxShape shape = BoxShape.rectangle;
    
    if (experience == Experience.bad) {
      // Oval eyes for bad (taller than wide) - use full circular radius
      borderRadius = BorderRadius.circular((width > height ? width : height) / 2);
    } else if (experience == Experience.notBad) {
      // Flat eyes for "not bad" - small radius for flat look
      borderRadius = BorderRadius.circular(8);
    } else {
      // Circular eyes for good (equal width and height)
      borderRadius = BorderRadius.circular((width > height ? width : height) / 2);
    }

    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          shape: shape,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

class AnimatedMouth extends StatelessWidget {
  final double rotation;
  final Color color;
  final double size;

  const AnimatedMouth({
    super.key,
    required this.rotation,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation,
      child: CustomPaint(
        size: Size(size, size * 0.5),  // Made mouth shorter in height
        painter: MouthPainter(color: color),
      ),
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
      ..strokeWidth = size.width * 0.08  // Thicker stroke for better visibility
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final centerX = size.width / 2;
    final startY = size.height * 0.2;  // Start lower
    
    // Less curved mouth - reduced curve depth
    path.moveTo(size.width * 0.25, startY);  // Start closer to center
    path.quadraticBezierTo(
      centerX,
      size.height * 0.6,  // Much less curve depth for subtle smile/frown
      size.width * 0.75,  // End closer to center
      startY,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}