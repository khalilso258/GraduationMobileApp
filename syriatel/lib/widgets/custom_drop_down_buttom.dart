import 'package:flutter/material.dart';
import 'package:syriatel/theme/size_config.dart';

class CustomDropdownSuffix extends StatelessWidget {
  final List<String> items;
  final Function(String) onItemSelected;

  const CustomDropdownSuffix({
    Key? key,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // الخط ملاصق للسهم تماماً
          Container(
            height: SizeConfig.scaleHeight(48),
            width: 1,
            color: Colors.grey.shade400,
          ),
          // لا مسافة هنا، فقط GestureDetector حول الأيقونة
          GestureDetector(
            onTapDown: (TapDownDetails details) async {
              final RenderBox renderBox = context.findRenderObject() as RenderBox;
              final Offset offset = renderBox.localToGlobal(Offset.zero);
              final selected = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(
                  offset.dx,
                  offset.dy + SizeConfig.scaleHeight(48),
                  offset.dx + 1,
                  0,
                ),
                items: items.map((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              );
              if (selected != null) {
                onItemSelected(selected);
              }
            },
            child: const Icon(Icons.arrow_drop_down),
          ),
        ],
      ),
    );
  }
}