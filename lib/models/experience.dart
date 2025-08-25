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
}