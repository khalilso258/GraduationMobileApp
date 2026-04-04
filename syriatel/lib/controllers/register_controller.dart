import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syriatel/view/login.dart';
import '../auth/api_service.dart';
import '../bindings/login_binding.dart';
import '../models/register_model.dart';
import '../widgets/app_notifier.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> registerKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isPassword = true.obs;
  RxString selectedGender = ''.obs;
  RxString simTypeController = ''.obs;

  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController phoneNumController;
  late TextEditingController addressController;
  late TextEditingController ageController; // تم تعديل الاسم بدل birthDay

  @override
  void onInit() {
    nameController = TextEditingController();
    passwordController = TextEditingController();
    phoneNumController = TextEditingController();
    addressController = TextEditingController();
    ageController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    phoneNumController.dispose();
    addressController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void changePasswordIcon() {
    isPassword.value = !isPassword.value;
  }

  String? validatePassword(String value) => value.isEmpty ? 'Please enter your password' : null;
  String? validateName(String value) => value.isEmpty ? 'Please enter your name' : null;
  String? validatePhoneNum(String value) => value.isEmpty ? 'Please enter your phone number' : null;
  String? validateAddress(String value) => value.isEmpty ? 'Please enter your address' : null;
  String? validateAge(String value) => value.isEmpty ? 'Please enter your age' : null;
  String? validateGender(String value) => value.isEmpty ? 'Please select your gender' : null;
  String? validateSimType(String value) => value.isEmpty ? 'Please select SIM type' : null;

  Future<void> doSignup() async {
    if (registerKey.currentState!.validate()) {
      isLoading.value = true;

      String formattedDate = DateTime.now().toIso8601String().split('T')[0]; // YYYY-MM-DD

      final model = RegisterRequestModel(
        username: nameController.text.trim(),
        password: passwordController.text,
        phoneNumber: phoneNumController.text.trim(),
        gender: selectedGender.value,
        location: addressController.text.trim(),
        lineType: simTypeController.value,
        signupDate: formattedDate,
        age: int.tryParse(ageController.text.trim()) ?? 0,
      );

      try {
        final response = await ApiService.registerUser(model);
        isLoading.value = false;

        if (response.statusCode == 200 || response.statusCode == 201) {
          AppNotifier.showSuccess('Success', 'Registration completed!');
          Get.offAll(() => Login(), binding: LoginBinding());

        } else {
          final error = response.body;
          print('❌ Registration failed with status: ${response.statusCode}');
          print('❌ Error body: $error');
          AppNotifier.showError('Error', 'Registration failed: $error');
        }
      } catch (e, stackTrace) {
        isLoading.value = false;
        print('❌ Exception occurred: $e');
        print('🔍 StackTrace: $stackTrace');
        AppNotifier.showError('Error', 'An error occurred: $e');
      }
    }
  }
}
