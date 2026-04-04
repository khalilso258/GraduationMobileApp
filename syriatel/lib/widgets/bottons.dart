import 'package:flutter/material.dart';
import 'package:syriatel/theme/colors.dart';
import '../theme/size_config.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;
  final double borderRadius;
  final String fontFamily;
  final Color fontColor;
  final double fontSize;
  final double x;
  final double y;
  final bool isLoading;

  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.thirdColor,
    this.width = 327,
    this.height = 56,
    this.borderRadius = 6,
    this.fontFamily = 'Bold',
    this.fontColor = Colors.white,
    this.fontSize = 16.0,
    this.x = 50,
    this.y = 647,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(borderRadius)),
        ),
        fixedSize: Size(
          SizeConfig.scaleWidth(width),
          SizeConfig.scaleHeight(height),
        ),
      ),
      child: isLoading
          ? const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 2.5,
        ),
      )
          : Text(
        text,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: SizeConfig.scaleWidth(fontSize),
          color: fontColor,
        ),
      ),
    );
  }
}
