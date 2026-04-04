import 'package:flutter/material.dart';
import 'package:syriatel/theme/size_config.dart'; // تأكد من أنك تستورده

class MyImage extends StatelessWidget {
  final String imagePath;

  final double width;
  final double height;

  const MyImage({
    super.key,
    required this.imagePath,

    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.scaleWidth(width),
      height: SizeConfig.scaleHeight(height),
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover, // أو BoxFit.fill حسب ما تريد
      ),
    );
  }
}
