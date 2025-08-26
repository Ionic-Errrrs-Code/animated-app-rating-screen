import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// App-wide spacing, radius, and duration constants to ensure consistency
class AppDimens {
  AppDimens._();

  // Spacing
  static EdgeInsets pageHPadding = EdgeInsets.symmetric(horizontal: 24.w);
  static double small = 8.h;
  static double medium = 16.h;
  static double large = 24.h;
  static double xLarge = 32.h;

  // Radii
  static double rSmall = 8.r;
  static double rMedium = 12.r;
  static double rLarge = 20.r;
  static double rPill = 30.r;

  // Slider
  static double sliderHandle = 36.r;

  // Face sizes (base factors)
  static Size faceSize(BuildContext context) => Size(0.5.sw, 0.2.sh);
}

class AppDurations {
  AppDurations._();

  static const short = Duration(milliseconds: 200);
  static const normal = Duration(milliseconds: 300);
  static const long = Duration(milliseconds: 400);
}

class AppStrings {
  AppStrings._();

  static const appTitle = 'SparkJoy - Rate Your Experience';
  static const headline = 'How was your experience?';
  static const addNotes = 'Add notes';
  static const submit = 'Submit';
  static const noteHint = 'Add note...';
}