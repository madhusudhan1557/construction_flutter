import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/validator.dart';

class CustomTextField {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double size;
  final double width;
  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    required this.size,
    this.prefixIcon,
    required this.width,
  });

  customTextField() {
    return Container(
      height: size,
      width: width,
      decoration: BoxDecoration(color: AppColors.customWhite),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
        validator: (value) => Validator.getBlankFieldValidator(value, hintText),
      ),
    );
  }
}
