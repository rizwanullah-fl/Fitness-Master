import 'dart:math' as math;
import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  final double animationValue; // This will control the animation
  final double waterLevelPercentage;

  WaveClipper(this.animationValue, this.waterLevelPercentage);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - (size.height * waterLevelPercentage / 100));

    // Adding sine wave animation using the animation value
    for (double i = 0.0; i <= size.width; i++) {
      path.lineTo(i, size.height - (size.height * waterLevelPercentage / 100) +
          10 * math.sin((i / size.width) * 2 * math.pi + animationValue));
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return oldClipper is WaveClipper && oldClipper.animationValue != animationValue;
  }
}
