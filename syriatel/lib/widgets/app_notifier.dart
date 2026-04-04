import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNotifier {
  static void showSuccess(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      icon: const Icon(Icons.check_circle, color: Colors.white),
      duration: const Duration(seconds: 2),
    );
  }

  static void showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(0.85),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.only(top: 0, left: 10, right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      icon: const Icon(Icons.error_outline, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }
}
