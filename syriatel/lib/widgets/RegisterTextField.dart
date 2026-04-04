import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syriatel/theme/size_config.dart';

class CustomDropdownField extends FormField<String> {
  CustomDropdownField({
    Key? key,
    required String label,
    required List<String> items,
    required RxString selectedValue,
    IconData? prefix,
    IconData? Function()? dynamicPrefix,// ✅ أضفنا هذا
    String? Function(String?)? validator,
  }) : super(
    key: key,
    validator: validator,
    builder: (FormFieldState<String> state) {
      final GlobalKey _key = GlobalKey();

      return Obx(() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.scaleHeight(16),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Color(0xFF888888),
                ),
              ),
            ),
          Container(
            key: _key,
            width: SizeConfig.scaleWidth(327),
            height: SizeConfig.scaleHeight(50),
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(
                color: state.hasError
                    ? Colors.red
                    : Colors.grey.shade400,
              ),
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                if (prefix != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      prefix,
                      color: Colors.grey,
                    ),
                  ),
                Expanded(
                  child: Text(
                    selectedValue.value.isEmpty
                        ? 'Select your $label'
                        : selectedValue.value,
                    style: TextStyle(
                      color: selectedValue.value.isEmpty
                          ? Colors.grey.shade500
                          : Colors.black,
                    ),
                  ),
                ),
                Container(
                  height: SizeConfig.scaleHeight(50),
                  width: 1,
                  color: Colors.grey.shade400,
                ),
                InkWell(
                  onTap: () async {
                    final RenderBox renderBox = _key
                        .currentContext!
                        .findRenderObject() as RenderBox;
                    final Offset offset =
                    renderBox.localToGlobal(Offset.zero);
                    final Size size = renderBox.size;

                    final value = await showMenu<String>(
                      context: state.context,
                      position: RelativeRect.fromLTRB(
                        offset.dx + size.width,
                        offset.dy + size.height,
                        offset.dx,
                        offset.dy,
                      ),
                      items: items
                          .map((item) => PopupMenuItem<String>(
                        value: item,
                        child: Text(item),
                      ))
                          .toList(),
                    );

                    if (value != null) {
                      selectedValue.value = value;
                      state.didChange(value);

                    }
                  },
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 0),
                    child: Icon(Icons.arrow_drop_down, size: 24),
                  ),
                ),
              ],
            ),
          ),
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6.0, left: 8),
              child: Text(
                state.errorText!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ));
    },
  );
}
