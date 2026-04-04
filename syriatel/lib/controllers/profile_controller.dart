import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syriatel/bindings/login_binding.dart';

import '../models/profile_model.dart';
import '../services/storage_service.dart';
import '../auth/api_service.dart';
import '../view/login.dart';
import '../widgets/app_notifier.dart';
import '../services/storage_service.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;

  late TextEditingController phoneController;
  late TextEditingController ageController;
  late TextEditingController addressController;

  var phone = ''.obs;
  var age = ''.obs;
  var address = ''.obs;
  var gender = ''.obs;
  var lineType = ''.obs;
  var signupDate = ''.obs;

  @override
  void onInit() {
    super.onInit();

    phoneController = TextEditingController();
    ageController = TextEditingController();
    addressController = TextEditingController();

    phoneController.addListener(() => phone.value = phoneController.text);
    ageController.addListener(() => age.value = ageController.text);
    addressController.addListener(() => address.value = addressController.text);

    fetchProfile();
  }

  @override
  void onClose() {
    phoneController.dispose();
    ageController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;

      final token = StorageService.getToken();
      if (token == null) {
        AppNotifier.showError('Error', 'User token not found');
        return;
      }

      final profile = await ApiService.getProfile(token);
      if (profile != null) {
        phoneController.text = profile.phoneNumber;
        ageController.text = profile.age.toString();
        addressController.text = profile.location;

        phone.value = profile.phoneNumber;
        age.value = profile.age.toString();
        address.value = profile.location;
        gender.value = profile.gender;
        lineType.value = profile.lineType;
        signupDate.value = profile.signupDate;
      }
    } catch (e) {
      AppNotifier.showError('Error', 'Failed to load profile');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateProfile() async {
    final token = StorageService.getToken();
    if (token == null) {
      AppNotifier.showError('Error', 'User token not found');
      return false;
    }

    final updatedProfile = ProfileModel(
      phoneNumber: phoneController.text.trim(),
      age: int.tryParse(ageController.text.trim()) ?? 0,
      gender: gender.value,
      lineType: lineType.value,
      location: addressController.text.trim(),
      signupDate: signupDate.value,
      monthlyUsage: [], // تأكد من ملئها إذا كنت تستخدمها
    );

    try {
      final response = await ApiService.updateProfile(token, updatedProfile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        await fetchProfile();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// تحديث مع عرض لودينغ و إظهار Snackbar
  Future<void> updateProfileWithLoadingAndFeedback() async {
    isLoading.value = true;

    // حذف عرض اللودينغ:
    /*
  await Get.dialog(
    WillPopScope(
      onWillPop: () async => false,
      child: const Center(child: CircularProgressIndicator()),
    ),
    barrierDismissible: false,
  );
  */

    final success = await updateProfile();

    // حذف إغلاق اللودينغ لأنه لم يعد موجودًا:
    /*
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
  */

    isLoading.value = false;

    if (success) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      AppNotifier.showSuccess('Success', 'Profile updated successfully');
    } else {
      AppNotifier.showError('Error', 'Failed to update profile');
    }
  }

  void logout() async {
    final token = StorageService.getToken();
    final refresh = StorageService.getRefreshToken();

    if (token != null && token.isNotEmpty) {
      // إرسال طلب تسجيل الخروج إلى الـ API باستخدام الـ access token
      final response = await ApiService.logout(refresh ?? "");

      // إذا كانت الاستجابة ناجحة، قم بتسجيل الخروج
      if (response.statusCode == 205) {
        await StorageService.clearTokens(); // مسح التوكن
        Get.offAll(() => Login() ,binding: LoginBinding()); // الانتقال إلى صفحة تسجيل الدخول
      } else {
        // في حالة حدوث خطأ، يمكن إظهار رسالة خطأ للمستخدم
        Get.snackbar('Error', 'Failed to log out', backgroundColor: Colors.red);
      }
    } else {
      // إذا كان التوكن غير موجود أو فارغ
      Get.snackbar('Error', 'You are not logged in', backgroundColor: Colors.red);
    }
  }


}
