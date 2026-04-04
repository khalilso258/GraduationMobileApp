// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:syriatel/theme/size_config.dart';

class CustomGradientBox extends StatelessWidget {
  final String title;
  final double percentage;
  final Color dotColor;

  const CustomGradientBox({
    super.key,
    required this.title,
    required this.percentage,
    required this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.scaleWidth(122),
      height: SizeConfig.scaleHeight(75),
      child: Container(
        padding: const EdgeInsets.all(5), // سمك الحواف
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEE2200),
              Color(0xFF969599),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10), // أقل لتظهر الحواف
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF242425),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: SizeConfig.scaleHeight(5)),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 0, end: percentage),
                          duration: const Duration(seconds: 1),
                          builder: (context, value, child) {
                            return Text(
                              '${value.toInt()}%',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: const Color(0x121212).withOpacity(0.7),
                                letterSpacing: 0.5,
                                height: 1,
                              ),
                            );
                          },
                        ),

                      ),
                    ],
                  ),


                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}
