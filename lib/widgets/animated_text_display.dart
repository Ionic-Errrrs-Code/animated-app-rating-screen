import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/experience.dart';
import '../utils/helpers.dart';

class AnimatedTextDisplay extends StatelessWidget {
  final double percentage;

  const AnimatedTextDisplay({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth * 0.15;

    final badPosition = _calculateBadPosition(percentage, screenWidth);
    final notBadPosition = _calculateNotBadPosition(percentage, screenWidth);
    final goodPosition = _calculateGoodPosition(percentage, screenWidth);

    final textStyle =  GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      color: Colors.black.withValues(alpha: 0.35),
      letterSpacing: -5.0,
    );

    return SizedBox(
      // --- Height increased to prevent clipping ---
      height: fontSize * 1.2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(offset: Offset(badPosition, 0), child: Text(Experience.bad.text, style: textStyle)),
          Transform.translate(offset: Offset(notBadPosition, 0), child: Text(Experience.notBad.text, style: textStyle)),
          Transform.translate(offset: Offset(goodPosition, 0), child: Text(Experience.good.text, style: textStyle)),
        ],
      ),
    );
  }

  // ... (_calculate... functions remain the same)
  double _calculateBadPosition(double percentage, double screenWidth) {
    if (percentage <= 0.5) {
      return lerpDouble(0, screenWidth, percentage / 0.5);
    }
    return screenWidth;
  }

  double _calculateNotBadPosition(double percentage, double screenWidth) {
    if (percentage <= 0.5) {
      return lerpDouble(-screenWidth, 0, percentage / 0.5);
    } else {
      return lerpDouble(0, screenWidth, (percentage - 0.5) / 0.5);
    }
  }

  double _calculateGoodPosition(double percentage, double screenWidth) {
    if (percentage > 0.5) {
      return lerpDouble(-screenWidth, 0, (percentage - 0.5) / 0.5);
    }
    return -screenWidth;
  }
}
