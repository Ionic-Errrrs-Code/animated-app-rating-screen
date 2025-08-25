import 'package:flutter/material.dart';

import '../models/experience.dart';
import '../widgets/animated_face.dart';
import '../widgets/animated_text_display.dart';
import '../widgets/experience_slider.dart';

class RateExperienceScreen extends StatefulWidget {
  const RateExperienceScreen({super.key});

  @override
  State<RateExperienceScreen> createState() => _RateExperienceScreenState();
}

class _RateExperienceScreenState extends State<RateExperienceScreen>
    with TickerProviderStateMixin {
  double _percentage = 1.0; // Start at "Good"
  Color _backgroundColor = Experience.good.backgroundColor;
  Color _darkColor = Experience.good.darkColor;
  Color _sliderColor = Experience.good.sliderColor;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 0),
        width: double.infinity,
        height: double.infinity,
        color: _backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              
              // Animated Face - bigger size with more space
              SizedBox(
                height: screenHeight * 0.35,
                child: Center(
                  child: AnimatedFace(
                    percentage: _percentage,
                    darkColor: _darkColor,
                    faceSize: Size(
                      screenWidth * 0.6,
                      screenHeight * 0.3,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: screenHeight * 0.02),  // Reduced spacing between face and text
              
              // Animated Text Display
              AnimatedTextDisplay(percentage: _percentage),
              
              const Spacer(flex: 2),
              
              // Experience Slider
              ExperienceSlider(
                darkColor: _darkColor,
                sliderColor: _sliderColor,
                initialValue: _percentage,
                onChanged: _handleSliderChange,
              ),
              
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSliderChange(double percentage) {
    setState(() {
      _percentage = percentage;
      
      // Calculate colors based on percentage
      if (percentage <= 0.5) {
        // Interpolate between Bad and NotBad
        final t = percentage / 0.5;
        _backgroundColor = Color.lerp(
          Experience.bad.backgroundColor,
          Experience.notBad.backgroundColor,
          t,
        )!;
        _darkColor = Color.lerp(
          Experience.bad.darkColor,
          Experience.notBad.darkColor,
          t,
        )!;
        _sliderColor = Color.lerp(
          Experience.bad.sliderColor,
          Experience.notBad.sliderColor,
          t,
        )!;
      } else {
        // Interpolate between NotBad and Good
        final t = (percentage - 0.5) / 0.5;
        _backgroundColor = Color.lerp(
          Experience.notBad.backgroundColor,
          Experience.good.backgroundColor,
          t,
        )!;
        _darkColor = Color.lerp(
          Experience.notBad.darkColor,
          Experience.good.darkColor,
          t,
        )!;
        _sliderColor = Color.lerp(
          Experience.notBad.sliderColor,
          Experience.good.sliderColor,
          t,
        )!;
      }
    });
  }
}