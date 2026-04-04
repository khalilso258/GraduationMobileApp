import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/activated_packages_controller.dart';
import '../widgets/activated_package_card.dart';
import '../widgets/custom_appbar.dart';

class ActivatedPackagesPage extends StatelessWidget {
  final controller = Get.put(ActivatedPackagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Activated Packages",
        iconImagePath: 'assets/images/bell.png',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.activatedPackages.isEmpty) {
          return const Center(child: Text("No activated packages found."));
        }

        return ListView.builder(
          itemCount: controller.activatedPackages.length,
          itemBuilder: (context, index) {
            return ActivatedPackageCard(
              package: controller.activatedPackages[index],
            );
          },
        );
      }),
    );
  }
}
