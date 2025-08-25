import 'package:flutter/material.dart';
import 'package:sparkjoy/models/experience.dart';

class AnimatedTextDisplay extends StatelessWidget {
  final double percentage;

  const AnimatedTextDisplay({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.12;
    
    // Calculate positions for each text
    final badPosition = _calculateBadPosition(percentage, screenWidth);
    final notBadPosition = _calculateNotBadPosition(percentage, screenWidth);
    final goodPosition = _calculateGoodPosition(percentage, screenWidth);

    return SizedBox(
      height: fontSize * 1.5,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // BAD text
          AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            left: badPosition,
            child: Text(
              Experience.bad.text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                color: Colors.black.withValues(alpha: 0.35),
                letterSpacing: -2.0,
              ),
            ),
          ),
          
          // NOT BAD text
          AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            left: notBadPosition,
            child: Text(
              Experience.notBad.text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                color: Colors.black.withValues(alpha: 0.35),
                letterSpacing: -2.0,
              ),
            ),
          ),
          
          // GOOD text
          AnimatedPositioned(
            duration: const Duration(milliseconds: 0),
            left: goodPosition,
            child: Text(
              Experience.good.text,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w900,
                color: Colors.black.withValues(alpha: 0.35),
                letterSpacing: -2.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateBadPosition(double percentage, double screenWidth) {
    if (percentage <= 0.5) {
      // Slide from center to right as we move away from bad
      return _lerpDouble(screenWidth * 0.35, screenWidth * 1.2, percentage / 0.5);
    }
    // Stay off-screen when in good territory
    return -screenWidth * 0.5;
  }

  double _calculateNotBadPosition(double percentage, double screenWidth) {
    if (percentage <= 0.5) {
      // Slide from off-screen left to center
      return _lerpDouble(-screenWidth * 0.5, screenWidth * 0.25, percentage / 0.5);
    } else if (percentage <= 0.75) {
      // Slide from center to right
      return _lerpDouble(screenWidth * 0.25, screenWidth * 1.2, (percentage - 0.5) / 0.25);
    }
    // Stay off-screen when fully in good territory
    return -screenWidth * 0.5;
  }

  double _calculateGoodPosition(double percentage, double screenWidth) {
    if (percentage > 0.75) {
      // Slide from off-screen left to center
      return _lerpDouble(-screenWidth * 0.5, screenWidth * 0.32, (percentage - 0.75) / 0.25);
    }
    // Stay off-screen when not in good territory
    return -screenWidth * 0.5;
  }

  double _lerpDouble(double a, double b, double t) {
    return a + (b - a) * t.clamp(0.0, 1.0);
  }
}