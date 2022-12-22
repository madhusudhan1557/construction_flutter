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
        controller: controller,
        decoration: InputDecoration(
          hintText: "Email",
          suffixIcon: suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
        ),
        validator: (value) => Validator.getEmailValidator(value),
      ),
    );
  }
}
