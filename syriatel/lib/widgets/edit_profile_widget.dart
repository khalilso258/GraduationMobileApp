import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfilePageDialogs {
  static void showEditDialog({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required Function(String) onSave,
  }) {
    final profileController = Get.find<ProfileController>();
    final tempController = TextEditingController(text: controller.text);

    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: 'Edit $label',
      titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      content: TextField(
        controller: tempController,
        keyboardType: (label.toLowerCase() == 'age' || label.toLowerCase() == 'phone')
            ? TextInputType.number
            : TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          onSave(tempController.text);
          await profileController.updateProfileWithLoadingAndFeedback();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(90, 36),
        ),
        child: const Text('Save', style: TextStyle(color: Colors.white)),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          minimumSize: const Size(90, 36),
        ),
        child: const Text('Cancel', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  static void showRadioDialog({
    required BuildContext context,
    required String label,
    required RxString selectedValue,
    required List<String> options,
  }) {
    final profileController = Get.find<ProfileController>();
    final tempValue = selectedValue.value.obs;

    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: 'Select $label',
      titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      content: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return RadioListTile<String>(
              title: Text(option),
              value: option,
              groupValue: tempValue.value.isEmpty ? null : tempValue.value,
              onChanged: (value) {
                if (value != null) {
                  tempValue.value = value;
                }
              },
              activeColor: Colors.green,
            );
          }).toList(),
        );
      }),
      confirm: ElevatedButton(
        onPressed: () async {
          if (tempValue.value.isNotEmpty) {
            selectedValue.value = tempValue.value;
            await profileController.updateProfileWithLoadingAndFeedback();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          minimumSize: const Size(90, 36),
        ),
        child: const Text('Save', style: TextStyle(color: Colors.white)),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          minimumSize: const Size(90, 36),
        ),
        child: const Text('Cancel', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
