import 'package:flutter/material.dart';
import '../models/experience.dart';
import '../widgets/action_buttons.dart';
import '../widgets/animated_face.dart';
import '../widgets/animated_text_display.dart';
import '../widgets/experience_slider.dart';
import '../widgets/note_input_view.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum ViewState { rating, note }

class RateExperienceScreen extends StatefulWidget {
  const RateExperienceScreen({super.key});

  @override
  State<RateExperienceScreen> createState() => _RateExperienceScreenState();
}

class _RateExperienceScreenState extends State<RateExperienceScreen> {
  final ValueNotifier<double> _percentage = ValueNotifier<double>(1.0);
  ViewState _viewState = ViewState.rating;
  final FocusNode _noteFocusNode = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isNoteView = _viewState == ViewState.note;

    return ValueListenableBuilder<double>(
      valueListenable: _percentage,
      builder: (context, value, child) {
        final colors = _getExperienceColors(value);
        final darkColor = colors['dark']!;

        return Scaffold(
          backgroundColor: colors['background'],
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              color: colors['background'],
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(child: ColoredBox(color: colors['background']!)),
                  // --- MAIN CONTENT AREA ---
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    top: isNoteView ? screenHeight * 0.1 : screenHeight * 0.15,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Text(
                          'How was your experience?',
                          style: TextStyle(
                            color: darkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            .animate(key: ValueKey(_viewState))
                            .fade(begin: isNoteView ? 1.0 : 0.0, end: isNoteView ? 0.0 : 1.0, duration: 300.ms),
                        const SizedBox(height: 24),
                        AnimatedFace(
                          percentage: value,
                          darkColor: darkColor,
                          faceSize: Size(screenWidth * 0.5, screenHeight * 0.2),
                        )
                            .animate()
                            .scale(
                              duration: 250.ms,
                              begin: const Offset(1, 1),
                              end: isNoteView ? const Offset(0.85, 0.85) : const Offset(1, 1),
                            )
                            .moveY(end: isNoteView ? -screenHeight * 0.05 : 0),
                        if (isNoteView)
                          NoteInputView(
                            darkColor: darkColor,
                            focusNode: _noteFocusNode,
                            onSubmit: () {},
                          )
                              .animate()
                              .fadeIn(duration: 250.ms, curve: Curves.easeOut)
                              .slideY(begin: 0.06, end: 0, duration: 280.ms, curve: Curves.easeOutCubic),
                      ],
                    ),
                  ),

                  // --- BOTTOM AREA ---
                  if (_viewState == ViewState.rating)
                    Column(
                      key: const ValueKey('rating_view'),
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const AnimatedTextDisplay(percentage: 1.0)
                            .animate()
                            .fadeIn(duration: 200.ms)
                            .slideY(begin: 0.05, end: 0, duration: 250.ms),
                        const SizedBox(height: 24),
                        ExperienceSlider(
                          darkColor: darkColor,
                          sliderColor: colors['slider']!,
                          initialValue: value,
                          onChanged: (p) => _percentage.value = p,
                        ).animate().fadeIn(duration: 220.ms).slideY(begin: 0.05, end: 0, duration: 260.ms),
                        const SizedBox(height: 16),
                        ActionButtons(
                          color: darkColor,
                          onAddNote: _switchToNoteView,
                          onSubmit: () {},
                        ).animate().fadeIn(duration: 240.ms).slideY(begin: 0.04, end: 0, duration: 280.ms),
                        const SizedBox(height: 24),
                      ],
                    ),

                  // --- TOP BUTTONS ---
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Map<String, Color> _getExperienceColors(double percentage) {
    Color backgroundColor, darkColor, sliderColor;
    if (percentage <= 0.5) {
      final t = percentage / 0.5;
      backgroundColor = Color.lerp(Experience.bad.backgroundColor, Experience.notBad.backgroundColor, t)!;
      darkColor = Color.lerp(Experience.bad.darkColor, Experience.notBad.darkColor, t)!;
      sliderColor = Color.lerp(Experience.bad.sliderColor, Experience.notBad.sliderColor, t)!;
    } else {
      final t = (percentage - 0.5) / 0.5;
      backgroundColor = Color.lerp(Experience.notBad.backgroundColor, Experience.good.backgroundColor, t)!;
      darkColor = Color.lerp(Experience.notBad.darkColor, Experience.good.darkColor, t)!;
      sliderColor = Color.lerp(Experience.notBad.sliderColor, Experience.good.sliderColor, t)!;
    }
    return {'background': backgroundColor, 'dark': darkColor, 'slider': sliderColor};
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