import 'package:flutter/material.dart';

enum Experience {
  bad,
  notBad,
  good;

  String get text {
    switch (this) {
      case Experience.good:
        return 'GOOD';
      case Experience.notBad:
        return 'NOT BAD';
      case Experience.bad:
        return 'BAD';
    }
  }

  Color get color {
    switch (this) {
      case Experience.good:
        return const Color(0xFFA8C25C);
      case Experience.notBad:
        return const Color(0xFFDFA141);
      case Experience.bad:
        return const Color(0xFFFF7759);
    }
  }

  Color get darkColor {
    switch (this) {
      case Experience.good:
        return const Color(0xFF1D4000);
      case Experience.notBad:
        return const Color(0xFF4E2800);
      case Experience.bad:
        return const Color(0xFF830E01);
    }
  }

  Color get sliderColor {
    switch (this) {
      case Experience.good:
        return const Color(0xFF9EB84B);
      case Experience.notBad:
        return const Color(0xFFD79721);
      case Experience.bad:
        return const Color(0xFFFA6E5A);
    }
  }
}