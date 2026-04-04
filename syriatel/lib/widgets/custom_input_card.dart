import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/size_config.dart';
import 'custom_botton.dart';

import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/size_config.dart';
import 'custom_botton.dart';

class UsageInputBox extends StatelessWidget {
  final String title;
  final TextEditingController controller;

  const UsageInputBox({
    super.key,
    required this.title,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.scaleWidth(101),
      height: SizeConfig.scaleHeight(60),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF8A8A8A),
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                isDense: true,
                hintText: '0',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------------

class CustomPackageCard extends StatelessWidget {
  final String packageName;
  final TextEditingController callsController;
  final TextEditingController messagesController;
  final TextEditingController internetController;
  final VoidCallback onActivate;

  const CustomPackageCard({
    super.key,
    required this.packageName,
    required this.callsController,
    required this.messagesController,
    required this.internetController,
    required this.onActivate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.scaleHeight(40)),
      child: Center(
        child: Container(
          height: SizeConfig.scaleHeight(230),
          width: SizeConfig.scaleWidth(413),
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
            padding: EdgeInsets.all(SizeConfig.scaleHeight(16)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  packageName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF242425),
                  ),
                ),
                SizedBox(height: SizeConfig.scaleHeight(16)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UsageInputBox(title: 'Calls', controller: callsController),
                    UsageInputBox(title: 'Messages', controller: messagesController),
                    UsageInputBox(title: 'Internet', controller: internetController),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeConfig.scaleHeight(35)),
                  child: Center(
                    child: CustomButton(
                      text: 'Activate',
                      color: AppColors.secondaryColor,
                      onPressed: onActivate,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
