import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syriatel/theme/colors.dart';

import '../controllers/profile_controller.dart';
import '../theme/size_config.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_info_box.dart';
import '../widgets/edit_profile_widget.dart';
import '../widgets/greadient_container.dart';
import '../widgets/logout_button.dart';
// استيراد الديالوغ

class ProfilePage extends StatelessWidget {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        iconImagePath: 'assets/images/bell.png',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GradientContainer(
                width: SizeConfig.screenWidth,
                height: SizeConfig.scaleHeight(270),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.scaleHeight(10)),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/profile.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text(
                        'Personal Info',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.scaleHeight(20)),

              Obx(() => CustomInfoBox(
                label: 'Phone',
                value: controller.phone.value,
                icon: Icons.phone,
                onEdit: () {
                  ProfilePageDialogs.showEditDialog(
                    context: context,
                    label: 'Phone',
                    controller: controller.phoneController,
                    onSave: (newValue) {
                      controller.phoneController.text = newValue;
                    },
                  );
                },
              )),

              SizedBox(height: SizeConfig.scaleHeight(12)),

              Obx(() => CustomInfoBox(
                label: 'Age',
                value: controller.age.value,
                icon: Icons.cake,
                onEdit: () {
                  ProfilePageDialogs.showEditDialog(
                    context: context,
                    label: 'Age',
                    controller: controller.ageController,
                    onSave: (newValue) {
                      if (int.tryParse(newValue) != null) {
                        controller.ageController.text = newValue;
                      }
                    },
                  );
                },
              )),

              SizedBox(height: SizeConfig.scaleHeight(12)),

              Obx(() => CustomInfoBox(
                label: 'Gender',
                value: controller.gender.value,
                icon: Icons.wc,
                onEdit: () {
                  ProfilePageDialogs.showRadioDialog(
                    context: context,
                    label: 'Gender',
                    selectedValue: controller.gender,
                    options: ['Male', 'Female'],
                  );
                },
              )),

              SizedBox(height: SizeConfig.scaleHeight(12)),

              Obx(() => CustomInfoBox(
                label: 'Location',
                value: controller.address.value,
                icon: Icons.location_on_outlined,
                onEdit: () {
                  ProfilePageDialogs.showEditDialog(
                    context: context,
                    label: 'Location',
                    controller: controller.addressController,
                    onSave: (newValue) {
                      controller.addressController.text = newValue;
                    },
                  );
                },
              )),

              SizedBox(height: SizeConfig.scaleHeight(12)),

              Obx(() => CustomInfoBox(
                label: 'Sim Type',
                value: controller.lineType.value,
                icon: Icons.sim_card,
                onEdit: () {
                  ProfilePageDialogs.showRadioDialog(
                    context: context,
                    label: 'Sim Type',
                    selectedValue: controller.lineType,
                    options: ['pre', 'post'],
                  );
                },
              )),

              SizedBox(height: SizeConfig.scaleHeight(12)),

              Obx(() => CustomInfoBox(
                label: 'Signup Date',
                value: controller.signupDate.value,
                icon: Icons.date_range,
                onEdit: null,
              )),
              SizedBox(height: SizeConfig.scaleHeight(40)),
              LogoutButton(
                onTap: () {
                  controller.logout();  // تنفيذ logout عند الضغط
                },
              ),
              SizedBox(height: SizeConfig.scaleHeight(30)),
            ],
          ),
        );
      }),
    );
  }
}
