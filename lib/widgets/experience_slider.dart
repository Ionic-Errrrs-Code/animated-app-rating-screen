import 'package:flutter/material.dart';
import 'animated_face.dart'; // We need the MouthPainter

class ExperienceSlider extends StatefulWidget {
  final Color darkColor;
  final Color sliderColor;
  final Function(double) onChanged;
  final double initialValue;

  const ExperienceSlider({
    super.key,
    required this.darkColor,
    required this.sliderColor,
    required this.onChanged,
    this.initialValue = 1.0,
  });

  @override
  State<ExperienceSlider> createState() => _ExperienceSliderState();
}

class _ExperienceSliderState extends State<ExperienceSlider> with TickerProviderStateMixin {
  late AnimationController _snapController;
  late Animation<double> _snapAnimation;
  double _currentValue = 1.0;

  // ... (initState, didUpdateWidget, dispose, and _snapToClosestPosition remain the same)
  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _snapController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _snapAnimation = Tween<double>(begin: _currentValue, end: _currentValue)
        .animate(CurvedAnimation(parent: _snapController, curve: Curves.elasticOut));

    _snapController.addListener(() {
      setState(() {
        _currentValue = _snapAnimation.value;
      });
      widget.onChanged(_currentValue);
    });
  }

  @override
  void didUpdateWidget(covariant ExperienceSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != _currentValue && !_snapController.isAnimating) {
      setState(() {
        _currentValue = widget.initialValue;
      });
    }
  }

  @override
  void dispose() {
    _snapController.dispose();
    super.dispose();
  }

  void _snapToClosestPosition() {
    double targetValue;
    if (_currentValue <= 0.25) {
      targetValue = 0.0;
    } else if (_currentValue <= 0.75) {
      targetValue = 0.5;
    } else {
      targetValue = 1.0;
    }

    _snapAnimation = Tween<double>(begin: _currentValue, end: targetValue)
        .animate(CurvedAnimation(parent: _snapController, curve: Curves.elasticOut));

    _snapController.reset();
    _snapController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final sliderWidth = constraints.maxWidth;
      final handleSize = 36.0;
      final trackWidth = sliderWidth - handleSize;

      return GestureDetector(
        onPanStart: (details) => _snapController.stop(),
        onPanUpdate: (details) {
          final newValue = (_currentValue + details.delta.dx / trackWidth).clamp(0.0, 1.0);
          setState(() => _currentValue = newValue);
          widget.onChanged(_currentValue);
        },
        onPanEnd: (details) => _snapToClosestPosition(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: sliderWidth * 0.08),
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(height: 6, decoration: BoxDecoration(color: widget.sliderColor, borderRadius: BorderRadius.circular(3))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(3, (index) => Container(width: 24, height: 24, decoration: BoxDecoration(color: widget.sliderColor, shape: BoxShape.circle))),
                    ),
                    Align(
                      alignment: Alignment(_currentValue * 2 - 1, 0),
                      child: _AnimatedHandle(
                        color: widget.darkColor,
                        size: handleSize,
                        percentage: _currentValue,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['Bad', 'Not bad', 'Good']
                    .map((label) => Text(label, style: TextStyle(color: widget.darkColor, fontSize: 14, fontWeight: FontWeight.bold)))
                    .toList(),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _AnimatedHandle extends StatelessWidget {
  final Color color;
  final double size;
  final double percentage;

  const _AnimatedHandle({required this.color, required this.size, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final mouthRotation = percentage <= 0.5 ? 3.14 : (1.0 - (percentage - 0.5) / 0.5) * 3.14;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Transform.rotate(
        angle: mouthRotation,
        child: Center(
          child: CustomPaint(
            size: Size(size * 0.4, size * 0.2),
            painter: MouthPainter(color: Colors.white.withValues(alpha: 0.8)), // Use the same painter
          ),
        ),
      ),
    );
  }
}
