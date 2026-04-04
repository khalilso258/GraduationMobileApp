import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../auth/api_service.dart';
import '../bindings/home_binding.dart';
import '../models/login_model.dart';
import '../services/storage_service.dart';
import '../view/main_screen.dart';
import '../widgets/app_notifier.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  RxBool isPassword = true.obs;

  late TextEditingController passwordController;
  late TextEditingController phoneNumController;

  @override
  void onInit() {
    passwordController = TextEditingController();
    phoneNumController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    passwordController.dispose();
    phoneNumController.dispose();
    super.dispose();
  }

  String? validatePassword(String value) =>
      value.isEmpty ? 'Please enter your Password' : null;
  String? validatePhoneNum(String value) =>
      value.isEmpty ? 'Please enter your Phone Number' : null;

  changePasswordIcon() {
    isPassword.value = !isPassword.value;
  }

  Future<void> doLogin() async {
    if (loginKey.currentState!.validate()) {
      isLoading.value = true;

      final model = LoginRequestModel(
        phone: phoneNumController.text.trim(),
        password: passwordController.text.trim(),
      );

      try {
        final response = await ApiService.loginUser(model);
        isLoading.value = false;
        print('💬 Response Body: ${response.body}');
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final loginResponse = LoginResponseModel.fromJson(data);

          await StorageService.saveToken(loginResponse.token);
          await StorageService.saveRefreshToken(loginResponse.refresh);
          AppNotifier.showSuccess('Success', 'Logged in');

          // ✅ الانتقال فقط عند النجاح
          Get.offAll(() => MainScreen(), binding: HomeBinding());

        } else {
          AppNotifier.showError('Login Failed', response.body);


        }
      } catch (e) {
        isLoading.value = false;
        AppNotifier.showError('Error', 'An error occurred: $e');
        print('An error occurred: $e');

      }
    }
  }

}
