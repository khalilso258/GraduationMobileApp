import 'package:flutter/material.dart';
import 'package:syriatel/theme/colors.dart';
import 'package:syriatel/theme/size_config.dart';

class CustomInfoBox extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onEdit;
  final bool editable;

  const CustomInfoBox({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.onEdit,
    this.editable = true, // افتراضيًا زر التعديل يظهر
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.scaleWidth(413),
      height: SizeConfig.scaleHeight(95),
      padding: EdgeInsets.all(SizeConfig.scaleWidth(5)),
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
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.scaleWidth(0),
          vertical: SizeConfig.scaleHeight(12),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Icon(
                icon,
                color: Colors.black54,
                size: SizeConfig.scaleWidth(28),
              ),
            ),
            SizedBox(width: SizeConfig.scaleWidth(50)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF242425),
                    ),
                  ),
                  SizedBox(height: SizeConfig.scaleHeight(4)),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            if (editable && onEdit != null)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.scaleWidth(14)),
                child: GestureDetector(
                  onTap: onEdit,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.scaleWidth(14),
                      vertical: SizeConfig.scaleHeight(6),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
