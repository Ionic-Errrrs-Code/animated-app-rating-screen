// lib/screens/rate_experience_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/experience.dart';
import '../utils/constants.dart';
import '../widgets/action_buttons.dart';
import '../widgets/animated_face.dart';
import '../widgets/animated_text_display.dart';
import '../widgets/experience_slider.dart';
import '../widgets/note_input_view.dart';
import 'thank_you_screen.dart'; // Import the new screen

enum ViewState { rating, note, submitted }

/// Main screen allowing users to rate their experience and optionally add notes.
class RateExperienceScreen extends StatefulWidget {
  const RateExperienceScreen({super.key});

  @override
  State<RateExperienceScreen> createState() => _RateExperienceScreenState();
}

class _RateExperienceScreenState extends State<RateExperienceScreen> {
  final ValueNotifier<double> _percentage = ValueNotifier<double>(1.0);
  ViewState _viewState = ViewState.rating;
  final FocusNode _noteFocusNode = FocusNode();
  Experience _submittedExperience = Experience.good;

  @override
  void initState() {
    super.initState();
    _noteFocusNode.addListener(() {
      if (!_noteFocusNode.hasFocus && _viewState == ViewState.note) {
        setState(() => _viewState = ViewState.rating);
      }
    });
  }

  @override
  void dispose() {
    _percentage.dispose();
    _noteFocusNode.dispose();
    super.dispose();
  }

  void _switchToNoteView() {
    setState(() => _viewState = ViewState.note);
    _noteFocusNode.requestFocus();
  }

  void _submitFeedback() {
    FocusScope.of(context).unfocus();
    setState(() {
      if (_percentage.value <= 0.25) {
        _submittedExperience = Experience.bad;
      } else if (_percentage.value <= 0.75) {
        _submittedExperience = Experience.notBad;
      } else {
        _submittedExperience = Experience.good;
      }
      _viewState = ViewState.submitted;
    });
  }

  void _resetScreen() {
    setState(() {
      _viewState = ViewState.rating;
      _percentage.value = 1.0; // Reset to a default value
    });
  }

  @override
  Widget build(BuildContext context) {
    final isNoteView = _viewState == ViewState.note;
    final isSubmitted = _viewState == ViewState.submitted;
    final viewInsets = MediaQuery.of(context).viewInsets;
    final isKeyboardVisible = viewInsets.bottom > 100;

    return ValueListenableBuilder<double>(
      valueListenable: _percentage,
      builder: (context, value, child) {
        final colors = Experience.colorsFor(value);
        final darkColor = colors['dark']!;

        return Scaffold(
          backgroundColor: colors['background'],
          resizeToAvoidBottomInset: false, // Handle padding manually
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: AnimatedContainer(
              duration: AppDurations.normal,
              color: colors['background'],
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // --- MAIN CONTENT & NOTE VIEW ---
                  Padding(
                    padding: EdgeInsets.only(bottom: viewInsets.bottom),
                    child: Column(
                      children: [
                        const Spacer(flex: 2),
                        Text(
                          isSubmitted ? ' ' : AppStrings.headline, // Hide text when submitted
                          style: GoogleFonts.inter(
                            color: darkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            // *** FIXED ANIMATION LOGIC ***
                            .animate(target: isNoteView || isSubmitted ? 1 : 0)
                            .fade(begin: 1, end: 0, duration: AppDurations.normal)
                            .slideY(begin: 0, end: -1.0, duration: AppDurations.long, curve: Curves.easeOutCubic),
                        SizedBox(height: AppDimens.large),
                        AnimatedFace(
                          percentage: value,
                          darkColor: darkColor,
                          faceSize: AppDimens.faceSize(context),
                        )
                            .animate(target: isKeyboardVisible ? 1 : 0)
                            .scale(
                              end: const Offset(0.8, 0.8),
                              duration: AppDurations.normal,
                              curve: Curves.easeOut,
                            ),
                        SizedBox(height: AppDimens.large),
                        if (isNoteView)
                          NoteInputView(
                            darkColor: darkColor,
                            focusNode: _noteFocusNode,
                            onSubmit: _submitFeedback,
                          )
                              .animate()
                              .fadeIn(duration: AppDurations.long, curve: Curves.easeOut)
                              .slideY(begin: 0.2, curve: Curves.easeOut),
                        const Spacer(flex: 4),
                      ],
                    ),
                  ),

                  // --- BOTTOM AREA ---
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedSwitcher(
                        duration: AppDurations.long,
                        switchInCurve: Curves.easeOutQuart,
                        switchOutCurve: Curves.easeInQuart,
                        child: _buildBottomContent(isNoteView, isSubmitted, darkColor, colors, value)),
                  ),

                  // --- TOP BUTTONS ---
                  if (!isSubmitted)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _TopIconButton(icon: Icons.close, color: darkColor, onTap: () {}),
                              _TopIconButton(icon: Icons.info_outline, color: darkColor, onTap: () {}),
                            ],
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: AppDurations.long).slideY(begin: -1, curve: Curves.easeOut),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomContent(bool isNoteView, bool isSubmitted, Color darkColor, Map<String, Color> colors, double value) {
    if (isSubmitted) {
      return ThankYouScreen(
        key: const ValueKey('thank_you_view'),
        experience: _submittedExperience,
        darkColor: darkColor,
        onContinue: _resetScreen,
      );
    } else if (isNoteView) {
      return const SizedBox(key: ValueKey('empty_bottom'));
    } else {
      return Column(
        key: const ValueKey('rating_view'),
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedTextDisplay(percentage: value),
          SizedBox(height: AppDimens.xLarge + AppDimens.small),
          ExperienceSlider(
            darkColor: darkColor,
            sliderColor: colors['slider']!,
            percentage: _percentage,
          ),
          SizedBox(height: AppDimens.xLarge * 2 + AppDimens.small),
          ActionButtons(
            color: darkColor,
            onAddNote: _switchToNoteView,
            onSubmit: _submitFeedback,
          ),
          SizedBox(height: AppDimens.xLarge * 1),
        ],
      ).animate(onPlay: (c) => c.forward())
          .fadeIn(duration: AppDurations.long, curve: Curves.easeOut)
          .slideY(begin: 0.5, duration: AppDurations.long, curve: Curves.easeOut);
    }
  }
}

class _TopIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _TopIconButton({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(25),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}