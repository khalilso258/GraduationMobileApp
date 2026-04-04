import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GenderController extends GetxController {
  RxString selectedGender = ''.obs;
  RxString errorText = ''.obs;

  void validateGender() {
    if (selectedGender.value.isEmpty) {
      errorText.value = 'Please select your Gender';
    } else {
      errorText.value = '';
    }
  }
}