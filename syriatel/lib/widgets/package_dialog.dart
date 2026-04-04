import 'package:flutter/material.dart';
import 'package:syriatel/theme/colors.dart';
import 'package:syriatel/widgets/custom_botton.dart';
import '../models/offers.dart';

import '../theme/size_config.dart';
import 'custom_offers_container.dart';  // استدعاء كلاس SizeConfig

import 'package:flutter/material.dart';
import 'package:syriatel/theme/colors.dart';
import 'package:syriatel/widgets/custom_botton.dart';
import '../models/offers.dart';

import '../theme/size_config.dart';
import 'custom_offers_container.dart';

class OfferDetailsSheet extends StatelessWidget {
  final OfferModel offer;
  final VoidCallback onPressed1;
  final VoidCallback onPressed2;

  const OfferDetailsSheet({
    super.key,
    required this.offer,
    required this.onPressed1,
    required this.onPressed2,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        SizeConfig.scaleWidth(20),
        SizeConfig.scaleHeight(20),
        SizeConfig.scaleWidth(20),
        SizeConfig.scaleHeight(40),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            offer.sourceType,
            style: TextStyle(
              fontSize: SizeConfig.scaleWidth(18),
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          Divider(thickness: 1),
          SizedBox(height: SizeConfig.scaleHeight(10)),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildUsageBox("Minutes", offer.calls),
                SizedBox(width: SizeConfig.scaleWidth(10)),
                _buildUsageBox("Messages", offer.messages),
                SizedBox(width: SizeConfig.scaleWidth(10)),
                _buildUsageBox("Internet", offer.internet),

              ],
            ),
          ),
          SizedBox(height: SizeConfig.scaleHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Offer generated date:",
                    style: TextStyle(fontSize: SizeConfig.scaleWidth(12)),
                  ),
                  Text(
                    "${offer.date}",
                    style: TextStyle(fontSize: SizeConfig.scaleWidth(12)),
                  ),
                ],
              ),
              Text(
                "Price: ${offer.price}",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: SizeConfig.scaleWidth(14),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.scaleHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButton(
                text: 'Deny',
                color: AppColors.primaryColor,
                onPressed: onPressed1,
              ),
              CustomButton(
                text: 'Accept',
                color: AppColors.secondaryColor,
                onPressed: onPressed2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUsageBox(String title, String value) {
    return Container(
      width: SizeConfig.scaleWidth(90),
      height: SizeConfig.scaleHeight(60),
      padding: EdgeInsets.all(SizeConfig.scaleWidth(8)),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(SizeConfig.scaleWidth(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: SizeConfig.scaleWidth(12),
              color: Colors.grey,
            ),
          ),
          SizedBox(height: SizeConfig.scaleHeight(4)),
          Text(
            value,
            style: TextStyle(
              fontSize: SizeConfig.scaleWidth(14),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

