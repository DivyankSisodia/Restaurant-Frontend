import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.textAlign,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final TextAlign textAlign;
  final IconData? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: textAlign,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.orange.shade500,
        ),
        suffixIcon: Icon(
          suffixIcon,
          color: Colors.orange.shade500,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange.shade500,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    );
  }
}
