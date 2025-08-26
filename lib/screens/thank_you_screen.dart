// lib/screens/thank_you_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/experience.dart';

class ThankYouScreen extends StatelessWidget {
  final Experience experience;
  final Color darkColor;
  final VoidCallback onContinue;

  const ThankYouScreen({
    super.key,
    required this.experience,
    required this.darkColor,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Thank you for your feedback!',
            style: GoogleFonts.inter(
              color: darkColor,
              fontSize: 24,
              fontWeight: FontWeight.w900, // Bolder font
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            experience.feedbackMessage,
            style: GoogleFonts.inter(
              color: darkColor.withValues(alpha: 0.8),
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 150),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: darkColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Continue Shopping',
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    ).animate().slideY(begin: 0.5, duration: 400.ms, curve: Curves.easeOut).fadeIn();
  }
}