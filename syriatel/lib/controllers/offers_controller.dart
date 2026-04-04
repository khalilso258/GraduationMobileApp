import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../auth/api_service.dart';
import '../models/offers.dart';
import '../services/storage_service.dart';
import '../widgets/app_notifier.dart';
import '../widgets/package_dialog.dart';
import 'activated_packages_controller.dart';

class OffersController extends GetxController {
  final offers = <OfferModel>[].obs;
  final currentIndex = 0.obs;
  final pageController = PageController();
  Timer? autoScrollTimer;

  final callsController = TextEditingController();
  final messagesController = TextEditingController();
  final internetController = TextEditingController();
  final isActivated = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOffersFromApi();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      autoScrollTimer = Timer.periodic(Duration(seconds: 5), (_) {
        if (pageController.hasClients) {
          if (currentIndex.value < offers.length - 1) {
            goToNext();
          } else {
            currentIndex.value = 0;
            pageController.animateToPage(
              0,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        }
      });
    });
  }

  @override
  void onClose() {
    autoScrollTimer?.cancel();
    callsController.dispose();
    messagesController.dispose();
    internetController.dispose();
    super.onClose();
  }

  // جلب العروض من API
  Future<void> fetchOffersFromApi() async {
    try {
      final token = await StorageService.getToken();
      if (token == null) {
        print('❌ لم يتم العثور على التوكين');
        return;
      }
      final result = await ApiService.getOffers(token);
      offers.assignAll(result);
    } catch (e) {
      print('❌ خطأ أثناء جلب العروض: $e');
    }
  }

  String getDisplayName(String? type) {
    switch (type) {
      case 'VAR':
        return 'Offer based on your preferences';
      case 'CLUSTER':
        return 'Offer tailored for your group';
      case 'XGBOOST':
        return 'AI-powered recommended offer';
      default:
        return 'Special offer';
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void goToPrevious() {
    if (pageController.hasClients && currentIndex.value > 0) {
      currentIndex.value--;
      pageController.animateToPage(
        currentIndex.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void goToNext() {
    if (pageController.hasClients && currentIndex.value < offers.length - 1) {
      currentIndex.value++;
      pageController.animateToPage(
        currentIndex.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void activateCurrentOffer() {
    final offer = offers[currentIndex.value];
    print(
        "✅ تم تفعيل العرض: ${offer.sourceType} - Calls: ${offer.calls}, Messages: ${offer.messages}, Internet: ${offer.internet}");
  }

  void onPressed1() {
    Get.back();
  }

  void onPressed2() {
    acceptCurrentOffer();
    Get.back();}

  void showOfferDetails(BuildContext context, OfferModel offer) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      builder: (_) => OfferDetailsSheet(
        offer: offer,
        onPressed1: onPressed1,
        onPressed2: onPressed2,
      ),
    );
  }

  void activatePackage() {
    print('✅ تفعيل عرض مخصص:');
    print('Calls: ${callsController.text}');
    print('Messages: ${messagesController.text}');
    print('Internet: ${internetController.text}');
    isActivated.value = true;
  }

  // دالة قبول الباقة
  void acceptCurrentOffer() async {
    try {
      final token = await StorageService.getToken();
      if (token == null) return;

      final offer = offers[currentIndex.value];
      final success = await ApiService.acceptPackage(token, offer.id);

      if (success) {
        print('✅ تم قبول الباقة: ${offer.sourceType}');
        AppNotifier.showSuccess("Accepted", "The package has been successfully accepted");

        // تحديث قائمة الباقات المفعلة مباشرة
        final activatedController = Get.find<ActivatedPackagesController>();
        await activatedController.fetchActivatedPackages();

      } else {
        print('❌ فشل قبول الباقة');
        AppNotifier.showError("Error", "Failed to accept the package");
      }
    } catch (e) {
      print('❌ خطأ أثناء قبول الباقة: $e');
    }
  }

}
