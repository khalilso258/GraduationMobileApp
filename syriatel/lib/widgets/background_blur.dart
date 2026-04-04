import 'dart:ui';
import 'package:flutter/material.dart';

class BackgroundBlurWithRadialGradient extends StatelessWidget {
  final double opacity;
  final Color color;
  final List<Color> gradientColors;
  final double blurSigma;

  const BackgroundBlurWithRadialGradient({
    Key? key,
    this.opacity = 0.74,
    this.color = Colors.white,
    this.gradientColors = const [Colors.white, Colors.transparent],
    this.blurSigma = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          // التدرج الدائري
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.8,
                colors: [
                  Colors.white.withOpacity(0.01),  // مركز الدائرة - فاتح
                  Colors.white.withOpacity(0.9),  // حولها - أفتح
                  Colors.transparent,             // الحواف - شفاف (انعكاس خفيف)
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),

          // البلور
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              color: color.withOpacity(opacity),
            ),
          ),
        ],
      ),
    );
  }
}
