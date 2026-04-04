import 'package:flutter/material.dart';
import 'package:syriatel/theme/size_config.dart';

class CirclePainter extends CustomPainter {
  final double diameter;
  final Color color;
  final String? text;
  final double fontSize;
  final Color textColor;
  final double xPosition;
  final double yPosition;

  CirclePainter({
    required this.diameter,
    required this.color,
    this.text,
    this.fontSize = 16.0,
    this.textColor = Colors.white,
    this.xPosition = 0.0,
    this.yPosition = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // رسم الدائرة (مع أخذ نصف القطر بالحسبان)
    canvas.drawCircle(
      Offset(
        SizeConfig.scaleWidth(xPosition + diameter / 2),
        SizeConfig.scaleHeight(yPosition + diameter / 2),
      ),
      SizeConfig.scaleWidth(diameter / 2),
      paint,
    );

    // رسم النص إذا كان موجودًا
    if (text != null && text!.isNotEmpty) {
      final TextSpan span = TextSpan(
        text: text,
        style: TextStyle(
          color: textColor,
          fontSize: SizeConfig.scaleWidth(fontSize),
        ),
      );

      final TextPainter textPainter = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      // الآن نرسم النص في وسط الدائرة
      textPainter.paint(
        canvas,
        Offset(
          SizeConfig.scaleWidth(xPosition + diameter / 2) - textPainter.width / 2,
          SizeConfig.scaleHeight(yPosition + diameter / 2) - textPainter.height / 2,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CircleWidget extends StatelessWidget {
  final double diameter;
  final Color color;
  final String? text;
  final double xPosition;
  final double yPosition;
  final double fontSize;
  final Color textColor;

  const CircleWidget({
    Key? key,
    required this.diameter,
    required this.color,
    this.text,
    this.fontSize = 16.0,
    this.textColor = Colors.white,
    this.xPosition = 0.0,
    this.yPosition = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(
        diameter: diameter,
        color: color,
        text: text,
        fontSize: fontSize,
        textColor: textColor,
        xPosition: xPosition,
        yPosition: yPosition,
      ),
      child: Container(),
    );
  }
}

