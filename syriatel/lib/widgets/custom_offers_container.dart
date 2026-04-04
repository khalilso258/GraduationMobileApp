import 'package:flutter/material.dart';

class UsageBox extends StatelessWidget {
  final String title;
  final String value;

  const UsageBox({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 101,
      height: 43,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12,
              fontWeight: FontWeight.w400, // Regular
              color: Color(0xFF8A8A8A),
            ),
          ),
          SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'Roboto',
              fontSize: 14,
              fontWeight: FontWeight.w500, // Medium
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
