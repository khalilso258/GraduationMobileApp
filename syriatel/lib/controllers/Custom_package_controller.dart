import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/storage_service.dart';
import '../auth/api_service.dart';
import '../widgets/app_notifier.dart';

class CustomPackageController extends GetxController {
  final callsController = TextEditingController();
  final messagesController = TextEditingController();
  final internetController = TextEditingController();

  final isActivated = false.obs;
  final isLoading = false.obs;

  @override
  void onClose() {
    callsController.dispose();
    messagesController.dispose();
    internetController.dispose();
    super.onClose();
  }

  Future<void> activatePackage() async {
    try {
      isLoading.value = true;
      final token = await StorageService.getToken();
      if (token == null) {
        Get.snackbar("Error", "No token found");
        return;
      }

      final internet = double.tryParse(internetController.text) ?? 0.0;
      final calls = int.tryParse(callsController.text) ?? 0;
      final sms = int.tryParse(messagesController.text) ?? 0;

      // إرسال البيانات بدون price، السيرفر يحسبها
      final success = await ApiService.activateClusterPackage(
        token: token,
        internet: internet,
        calls: calls,
        sms: sms,
      );

      if (success) {
        isActivated.value = true;
        Get.snackbar("Success", "Package activated successfully");
      } else {
        Get.snackbar("Error", "Activation failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
