import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
class AnimatedShape extends StatelessWidget {
  final double size;
  final Color color;
  final BoxShape shape;
  final BorderRadius? borderRadius;
  final Duration delay;

  const AnimatedShape({
    super.key,
    required this.size,
    required this.color,
    required this.shape,

    this.borderRadius,
    required this.delay,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        ScaleEffect(
          duration: Duration(seconds: 4),
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.1, 1.1),
          curve: Curves.easeInOut,
        ),
      ],
      delay: delay,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: shape,
          borderRadius: shape == BoxShape.rectangle ? borderRadius : null,
        ),
      ),
    );
  }
}
