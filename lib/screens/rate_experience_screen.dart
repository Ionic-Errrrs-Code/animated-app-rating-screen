import 'package:flutter/material.dart';
import '../models/experience.dart';
import '../widgets/eye_widget.dart';
import '../widgets/mouth_painter.dart';
import '../widgets/experience_slider.dart';

class RateExperienceScreen extends StatefulWidget {
  const RateExperienceScreen({super.key});

  @override
  State<RateExperienceScreen> createState() => _RateExperienceScreenState();
}

class _RateExperienceScreenState extends State<RateExperienceScreen>
    with TickerProviderStateMixin {
  late Experience _experience;
  late Color _color;
  late Color _darkColor;
  late double _mouthRotation;
  late double _eyeHeight;
  late double _eyeWidth;
  late double _eyeRotation;
  late Color _sliderColor;
  late double _badTextPosition;
  late double _notBadTextPosition;
  late double _goodTextPosition;

  @override
  void initState() {
    super.initState();
    _experience = Experience.good;
    _color = _experience.color;
    _darkColor = _experience.darkColor;
    _mouthRotation = 0.0;
    _eyeHeight = 88.0;
    _eyeWidth = 88.0;
    _eyeRotation = 0.0;
    _sliderColor = _experience.sliderColor;
    _badTextPosition = -350.0;
    _notBadTextPosition = -350.0;
    _goodTextPosition = 0.0;
  }

  void _onSliderScroll(double percentage) {
    setState(() {
      Color targetColor;
      double targetRotation;
      Color targetDarkColor;
      Color targetSliderColor;

      if (percentage <= 0.5) {
        // Bad to Not Bad
        targetColor = Color.lerp(
          Experience.bad.color,
          Experience.notBad.color,
          percentage / 0.5,
        )!;
        targetRotation = 180.0;
        targetDarkColor = Color.lerp(
          Experience.bad.darkColor,
          Experience.notBad.darkColor,
          percentage / 0.5,
        )!;
        _eyeHeight = lerpDouble(32.0, 28.0, percentage / 0.5)!;
        _eyeWidth = lerpDouble(32.0, 88.0, percentage / 0.5)!;
        _eyeRotation = lerpDouble(100.0, 0.0, percentage / 0.5)!;
        targetSliderColor = Color.lerp(
          Experience.bad.sliderColor,
          Experience.notBad.sliderColor,
          percentage / 0.5,
        )!;
        _badTextPosition = lerpDouble(0.0, 300.0, percentage / 0.5)!;
      } else {
        // Not Bad to Good
        targetColor = Color.lerp(
          Experience.notBad.color,
          Experience.good.color,
          (percentage - 0.5) / 0.5,
        )!;
        targetRotation = lerpDouble(180.0, 0.0, (percentage - 0.5) / 0.5)!;
        targetDarkColor = Color.lerp(
          Experience.notBad.darkColor,
          Experience.good.darkColor,
          (percentage - 0.5) / 0.5,
        )!;
        _eyeHeight = lerpDouble(28.0, 88.0, (percentage - 0.5) / 0.5)!;
        _eyeWidth = lerpDouble(88.0, 88.0, (percentage - 0.5) / 0.5)!;
        _eyeRotation = lerpDouble(0.0, 0.0, (percentage - 0.5) / 0.5)!;
        targetSliderColor = Color.lerp(
          Experience.notBad.sliderColor,
          Experience.good.sliderColor,
          (percentage - 0.5) / 0.5,
        )!;
        _badTextPosition = -300.0;
      }

      // Handle text positions
      if (percentage <= 0.5) {
        _notBadTextPosition = lerpDouble(-350.0, 0.0, percentage / 0.5)!;
      } else if (percentage <= 0.75) {
        _notBadTextPosition = lerpDouble(0.0, 350.0, (percentage - 0.5) / 0.25)!;
      } else {
        _notBadTextPosition = -350.0;
      }

      _goodTextPosition = percentage > 0.75
          ? lerpDouble(-300.0, 0.0, (percentage - 0.75) / 0.25)!
          : -300.0;

      // Update all values
      _color = targetColor;
      _darkColor = targetDarkColor;
      _mouthRotation = targetRotation;
      _sliderColor = targetSliderColor;

      // Update experience based on percentage
      if (percentage >= 0.45 && percentage <= 0.55) {
        _experience = Experience.notBad;
      } else if (percentage <= 0.44) {
        _experience = Experience.bad;
      } else {
        _experience = Experience.good;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _color,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Face section
            SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      EyeWidget(
                        experience: _experience,
                        color: _darkColor,
                        width: _eyeWidth,
                        height: _eyeHeight,
                        rotation: -_eyeRotation,
                      ),
                      const SizedBox(width: 16),
                      EyeWidget(
                        experience: _experience,
                        color: _darkColor,
                        width: _eyeWidth,
                        height: _eyeHeight,
                        rotation: _eyeRotation,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CustomPaint(
                      painter: MouthPainter(
                        rotation: _mouthRotation,
                        color: _darkColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 44),
            
            // Text section
            SizedBox(
              height: 80,
              child: Stack(
                children: [
                  // Good text
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: _goodTextPosition,
                    top: 0,
                    child: Text(
                      Experience.good.text,
                      style: TextStyle(
                        fontSize: 60,
                        letterSpacing: -4.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ),
                  ),
                  
                  // Bad text
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: _badTextPosition,
                    top: 0,
                    child: Text(
                      Experience.bad.text,
                      style: TextStyle(
                        fontSize: 60,
                        letterSpacing: -4.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ),
                  ),
                  
                  // Not Bad text
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: _notBadTextPosition,
                    top: 0,
                    child: Text(
                      Experience.notBad.text,
                      style: TextStyle(
                        fontSize: 60,
                        letterSpacing: -4.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Slider
            ExperienceSlider(
              experience: _experience,
              darkColor: _darkColor,
              sliderColor: _sliderColor,
              onScroll: _onSliderScroll,
            ),
          ],
        ),
      ),
    );
  }
}