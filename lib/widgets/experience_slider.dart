import 'package:flutter/material.dart';
import 'dart:math' as math;

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

class _ExperienceSliderState extends State<ExperienceSlider>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;
  double _currentValue = 1.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<double>(
      begin: _currentValue,
      end: _currentValue,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _snapToClosestPosition(double value) {
    double targetValue;
    
    if (value <= 0.25) {
      targetValue = 0.0; // Bad
    } else if (value <= 0.75) {
      targetValue = 0.5; // Not Bad
    } else {
      targetValue = 1.0; // Good
    }

    _slideAnimation = Tween<double>(
      begin: _currentValue,
      end: targetValue,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _slideController.reset();
    _slideController.forward();

    _slideAnimation.addListener(() {
      setState(() {
        _currentValue = _slideAnimation.value;
      });
      widget.onChanged(_currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final sliderPadding = screenWidth * 0.08;
    final sliderWidth = screenWidth - (sliderPadding * 2);
    final handlePosition = _currentValue * (sliderWidth - 36);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sliderPadding),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                // Slider track
                Positioned(
                  left: 18,
                  right: 18,
                  top: 22,
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: widget.sliderColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                
                // Slider markers
                Positioned(
                  left: 18,
                  top: 10,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: widget.sliderColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: (sliderWidth / 2) - 12 + 18,
                  top: 10,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: widget.sliderColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 10,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: widget.sliderColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                
                // Draggable handle
                Positioned(
                  left: handlePosition,
                  child: GestureDetector(
                    onPanStart: (_) {
                      _isDragging = true;
                      _slideController.stop();
                    },
                    onPanUpdate: (details) {
                      final RenderBox renderBox = context.findRenderObject() as RenderBox;
                      final localPosition = renderBox.globalToLocal(details.globalPosition);
                      final newValue = ((localPosition.dx - 18) / (sliderWidth - 36)).clamp(0.0, 1.0);
                      
                      setState(() {
                        _currentValue = newValue;
                      });
                      widget.onChanged(_currentValue);
                    },
                    onPanEnd: (_) {
                      _isDragging = false;
                      _snapToClosestPosition(_currentValue);
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: widget.darkColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Bad',
                style: TextStyle(
                  color: widget.darkColor,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Not bad',
                style: TextStyle(
                  color: widget.darkColor,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Good',
                style: TextStyle(
                  color: widget.darkColor,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}