import 'package:flutter/material.dart';
import '../models/experience.dart';

class EyeWidget extends StatelessWidget {
  final Experience experience;
  final Color color;
  final double width;
  final double height;
  final double rotation;

  const EyeWidget({
    super.key,
    required this.experience,
    required this.color,
    required this.width,
    required this.height,
    required this.rotation,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotation * 3.14159 / 180,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          shape: experience == Experience.good ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: experience == Experience.notBad 
              ? BorderRadius.circular(height / 2) // Flat rectangle with rounded corners
              : experience == Experience.bad
                  ? BorderRadius.circular(height / 2) // Oval shape
                  : null, // Circle for good
        ),
      ),
    );
  }
}