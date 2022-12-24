import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/validator.dart';

class CustomEmailField {
  final TextEditingController controller;
  final Icon? suffixIcon;
  final double size;
  const CustomEmailField({
    required this.controller,
    this.suffixIcon,
    required this.size,
  });

  customEmailField() {
    return Container(
      height: size,
      decoration: BoxDecoration(color: AppColors.customWhite),
      child: TextFormField(
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          hintText: "Email",
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
        validator: (value) => Validator.getEmailValidator(value),
      ),
    );
  }
}
