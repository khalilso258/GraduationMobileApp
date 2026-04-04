import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_buttom_navigation_bar.dart';
import 'ActivatedPackagesPage.dart';
import 'offers_page.dart';
import 'home.dart';
import 'profile.dart';

class MainScreenController extends GetxController {
  var currentIndex = 1.obs;

  void changeTab(int index) {
    currentIndex.value = index;
  }
}

class MainScreen extends StatelessWidget {
  final MainScreenController controller = Get.put(MainScreenController());

  final List<Widget> _pages = [
    OffersPage(),
    Home(),
    ActivatedPackagesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: _pages[controller.currentIndex.value],
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
        ),
      );
    });
  }
}
