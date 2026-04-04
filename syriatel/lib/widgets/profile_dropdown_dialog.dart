import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/colors.dart';
import '../theme/size_config.dart';
import 'RegisterTextField.dart';
import 'app_notifier.dart';


void showEditDropdownDialog({
  required String label,
  required RxString selectedValue,
  required List<String> options,
  required void Function(String) onSave,
}) {
  final RxString tempValue = selectedValue.value.obs;

  Get.bottomSheet(
    Container(
      width: SizeConfig.screenWidth,
      padding: EdgeInsets.all(SizeConfig.scaleWidth(7)),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEE2200),
            Color(0xFF969599),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.scaleHeight(20)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Edit $label",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: SizeConfig.scaleHeight(20)),

            // ✅ هذا هو الحقل الذي تريده بنفس تصميمك
            CustomDropdownField(
              label: label,
              items: options,
              selectedValue: tempValue,
            ),

            SizedBox(height: SizeConfig.scaleHeight(20)),

            ElevatedButton(
              onPressed: () {
                selectedValue.value = tempValue.value;
                onSave(tempValue.value);
                Get.back();
                AppNotifier.showSuccess('Success', '$label updated successfully!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondaryColor,
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
  );
}
