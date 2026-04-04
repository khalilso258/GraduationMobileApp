import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget? child;
  final BorderRadius? borderRadius;

  const GradientContainer({
    Key? key,
    this.width = double.infinity,
    this.height = 100,
    this.child,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFEE2200), // اللون الأول
             // اللون الثاني
            Colors.white,      // تدرج اللون الثاني إلى الأبيض
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),

      ),
      child: child,
    );
  }
}
