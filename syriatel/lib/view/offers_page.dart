import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/offers_controller.dart';
import '../controllers/Custom_package_controller.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/custom_cart.dart';
import '../widgets/custom_input_card.dart';
import '../theme/colors.dart';
import '../theme/size_config.dart';

class OffersPage extends StatelessWidget {
  final OffersController controller = Get.put(OffersController());
  final CustomPackageController controller1 = Get.put(CustomPackageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Syriatel Offers',
        iconImagePath: 'assets/images/bell.png',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(),
            SizedBox(height: SizeConfig.scaleHeight(10)),
            _buildOffersCarousel(),
            SizedBox(height: SizeConfig.scaleHeight(10)),
            _buildNavigationControls(),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.scaleWidth(42),
                top: SizeConfig.scaleHeight(40),
              ),
              child: Text(
                'Create your Own Package',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
              CustomPackageCard(
                packageName: 'Your Offer',
                callsController: controller1.callsController,
                messagesController: controller1.messagesController,
                internetController: controller1.internetController,
                onActivate: controller1.activatePackage,
              )

              ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.scaleWidth(42),
        top: SizeConfig.scaleHeight(20),
      ),
      child: Text(
        'Suggested offers',
        style: GoogleFonts.roboto(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildOffersCarousel() {
    return SizedBox(
      height: SizeConfig.scaleHeight(280),
      child: Obx(() {
        final offers = controller.offers;

        if (offers.isEmpty) {
          return Center(
            child: Text(
              'No available offers',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          );
        }

        return PageView.builder(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          itemCount: offers.length,
          itemBuilder: (context, index) {
            final offer = offers[index];
            return PackageCard(
              packageName: controller.getDisplayName(offer.sourceType),
              calls: offer.calls,
              messages: offer.messages,
              internet: offer.internet,
              onActivate: () => controller.showOfferDetails(context, offer),
            );
          },
        );
      }),
    );
  }


  Widget _buildNavigationControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildArrowButton(Icons.arrow_back_ios_new_outlined, controller.goToPrevious),
        SizedBox(width: SizeConfig.scaleWidth(16)),
        _buildDots(),
        SizedBox(width: SizeConfig.scaleWidth(16)),
        _buildArrowButton(Icons.arrow_forward_ios_outlined, controller.goToNext),
      ],
    );
  }

  Widget _buildArrowButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.secondaryColor, width: 2),
        ),
        child: Icon(icon, size: 18, color: AppColors.secondaryColor),
      ),
    );
  }

  Widget _buildDots() {
    return Obx(() {
      final offersLength = controller.offers.length;
      final currentIndex = controller.currentIndex.value;

      int totalDots = offersLength > 4 ? 4 : offersLength;
      int activeIndex = (offersLength <= 4 || currentIndex <= 3)
          ? currentIndex
          : 3;

      return Row(
        children: List.generate(totalDots, (i) {
          bool isActive = i == activeIndex;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 10 : 8,
            height: isActive ? 10 : 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.secondaryColor : Colors.grey[300],
            ),
          );
        }),
      );
    });
  }
}
