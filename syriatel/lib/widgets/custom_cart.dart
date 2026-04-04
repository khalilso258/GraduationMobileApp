import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/size_config.dart';
import 'custom_botton.dart';
import 'custom_offers_container.dart';

class PackageCard extends StatelessWidget {
  final String packageName;
  final String calls;
  final String messages;
  final String internet;
  final VoidCallback? onActivate;
  final bool showActivateButton;

  const PackageCard({
    Key? key,
    required this.packageName,
    required this.calls,
    required this.messages,
    required this.internet,
    this.onActivate,
    this.showActivateButton = true,
  }) : super(key: key);

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
                SizedBox(height: SizeConfig.scaleHeight(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    UsageBox(title: 'Calls', value: calls),
                    UsageBox(title: 'Messages', value: messages),
                    UsageBox(title: 'Internet', value: internet),
                  ],
                ),
                if (showActivateButton)
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.scaleHeight(35)),
                    child: Center(
                      child: CustomButton(
                        text: 'Activate',
                        color: AppColors.secondaryColor,
                        onPressed: onActivate ?? () {},
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
