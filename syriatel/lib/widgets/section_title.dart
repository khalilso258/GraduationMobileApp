import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syriatel/theme/colors.dart';
import 'package:syriatel/theme/size_config.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.scaleWidth(42),
        top: SizeConfig.scaleHeight(20),
      ),
      child: Text(
        title,
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
