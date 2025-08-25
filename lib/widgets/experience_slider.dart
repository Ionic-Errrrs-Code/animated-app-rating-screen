import 'package:flutter/material.dart';
import '../models/experience.dart';

class ExperienceSlider extends StatefulWidget {
  final Experience experience;
  final Color darkColor;
  final Color sliderColor;
  final Function(double) onScroll;

  const ExperienceSlider({
    super.key,
    required this.experience,
    required this.darkColor,
    required this.sliderColor,
    required this.onScroll,
  });

  @override
  State<ExperienceSlider> createState() => _ExperienceSliderState();
}

class _ExperienceSliderState extends State<ExperienceSlider>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _dragOffset = 0.0;
  double _maxOffset = 0.0;
  double _centerOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateOffsets();
    });
  }

  void _calculateOffsets() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final size = renderBox.size;
      const padding = 64.0 + 12.0 + 24.0;
      _maxOffset = size.width - padding;
      _centerOffset = _maxOffset / 2;
      _dragOffset = _maxOffset;
    }
  }

  double _snapToClosestOffset(double currentOffset) {
    final distances = <double, double>{
      0.0: (currentOffset - 0.0).abs(),
      _centerOffset: (currentOffset - _centerOffset).abs(),
      _maxOffset: (currentOffset - _maxOffset).abs(),
    };
    
    final closest = distances.entries
        .reduce((a, b) => a.value < b.value ? a : b);
    
    return closest.key;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final newOffset = (_dragOffset + details.delta.dx)
        .clamp(0.0, _maxOffset);
    
    setState(() {
      _dragOffset = newOffset;
    });
    
    final percentage = newOffset / _maxOffset;
    widget.onScroll(percentage);
  }

  void _onDragEnd(DragEndDetails details) {
    final snappedOffset = _snapToClosestOffset(_dragOffset);
    final percentage = snappedOffset / _maxOffset;
    
    widget.onScroll(percentage);
    
    _animationController.forward(from: 0.0).then((_) {
      setState(() {
        _dragOffset = snappedOffset;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 32),
          child: Stack(
            children: [
              // Slider track
              Container(
                margin: const EdgeInsets.only(top: 8.5, bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                height: 6,
                decoration: BoxDecoration(
                  color: widget.sliderColor,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              
              // Labels
              Positioned(
                top: 30,
                left: 4,
                child: Text(
                  'Bad',
                  style: TextStyle(
                    color: widget.darkColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              Positioned(
                top: 30,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Not bad',
                    style: TextStyle(
                      color: widget.darkColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              
              Positioned(
                top: 30,
                right: 0,
                child: Text(
                  'Good',
                  style: TextStyle(
                    color: widget.darkColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              
              // Slider dots
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) => 
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: widget.sliderColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              
              // Draggable handle
              Positioned(
                top: -8,
                left: _dragOffset - 18, // Center the handle
                child: GestureDetector(
                  onPanUpdate: _onDragUpdate,
                  onPanEnd: _onDragEnd,
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
        );
      },
    );
  }
}