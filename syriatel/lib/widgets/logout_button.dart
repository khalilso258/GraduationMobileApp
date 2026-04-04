import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syriatel/theme/colors.dart';

import '../theme/size_config.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;  // استقبال الدالة من الصفحة الأم

  const LogoutButton({super.key, required this.onTap}); // تمرير الدالة عبر الـ constructor

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,  // عند الضغط، تنفيذ الدالة الممررة
      child: Container(
        width: SizeConfig.screenWidth * 0.8,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          'Logout',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
