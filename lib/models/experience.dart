import 'package:flutter/material.dart';

enum Experience {
  bad,
  notBad,
  good;

  Color get backgroundColor {
    switch (this) {
      case Experience.bad:
        return const Color(0xFFFF7759);
      case Experience.notBad:
        return const Color(0xFFDFA141);
      case Experience.good:
        return const Color(0xFFA8C25C);
    }
  }

  Color get darkColor {
    switch (this) {
      case Experience.bad:
        return const Color(0xFF830E01);
      case Experience.notBad:
        return const Color(0xFF4E2800);
      case Experience.good:
        return const Color(0xFF1D4000);
    }
  }

  Color get sliderColor {
    switch (this) {
      case Experience.bad:
        return const Color(0xFFFA6E5A);
      case Experience.notBad:
        return const Color(0xFFD79721);
      case Experience.good:
        return const Color(0xFF9EB84B);
    }
  }

  String get text {
    switch (this) {
      case Experience.bad:
        return 'BAD';
      case Experience.notBad:
        return 'NOT BAD';
      case Experience.good:
        return 'GOOD';
    }
  }

  String get feedbackMessage {
    switch (this) {
      case Experience.bad:
        return "We're sorry to hear about your experience. We're constantly working to improve and appreciate your feedback.";
      case Experience.notBad:
        return "Thanks for your feedback! We're always looking for ways to make our service even better.";
      case Experience.good:
        return "Excellent! We're thrilled you had a great experience. We look forward to serving you again soon.";
    }
  }

  static Map<String, Color> colorsFor(double percentage) {
    if (percentage <= 0.5) {
      final t = percentage / 0.5;
      return {
        'background': Color.lerp(Experience.bad.backgroundColor, Experience.notBad.backgroundColor, t)!,
        'dark': Color.lerp(Experience.bad.darkColor, Experience.notBad.darkColor, t)!,
        'slider': Color.lerp(Experience.bad.sliderColor, Experience.notBad.sliderColor, t)!,
      };
    } else {
      final t = (percentage - 0.5) / 0.5;
      return {
        'background': Color.lerp(Experience.notBad.backgroundColor, Experience.good.backgroundColor, t)!,
        'dark': Color.lerp(Experience.notBad.darkColor, Experience.good.darkColor, t)!,
        'slider': Color.lerp(Experience.notBad.sliderColor, Experience.good.sliderColor, t)!,
      };
    }
  }
}
