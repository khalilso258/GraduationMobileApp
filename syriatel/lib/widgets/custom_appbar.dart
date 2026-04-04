import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String iconImagePath;
  final Color backgroundColor; // لون الخلفية (افتراضي أبيض)

  const CustomAppBar({
    required this.title,
    required this.iconImagePath,
    this.backgroundColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // تحديد سطوع الأيقونات حسب لون الخلفية
    final Brightness iconBrightness =
    ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
        ? Brightness.light
        : Brightness.dark;

    // ضبط مظهر شريط الحالة
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: backgroundColor,
      statusBarIconBrightness: iconBrightness,
      statusBarBrightness: iconBrightness, // للأجهزة التي تستخدم iOS
    ));

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          fontSize: 22,
          color: const Color(0xFF242425),
        ),
        overflow: TextOverflow.ellipsis,
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Image.asset(
            iconImagePath,
            width: 28,
            height: 28,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
